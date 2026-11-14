# /// script
# dependencies = [
#   "google-genai",
# ]
# ///

import argparse
import os
import sys
import json
from google import genai


def main():
    parser = argparse.ArgumentParser(
        description="Search Google via the Gemini Interactions API."
    )
    parser.add_argument("query", help="The search query or prompt.")
    parser.add_argument(
        "--model",
        default="gemini-2.5-flash-lite",
        help="The model to use (default: gemini-2.5-flash-lite).",
    )
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--json",
        action="store_true",
        help="Output parsed JSON with answer, queries, and citations.",
    )
    group.add_argument(
        "--raw",
        action="store_true",
        help="Output the raw API interaction steps as JSON.",
    )

    args = parser.parse_args()

    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("Error: GEMINI_API_KEY environment variable is not set.", file=sys.stderr)
        sys.exit(1)

    try:
        client = genai.Client()
        interaction = client.interactions.create(
            model=args.model, input=args.query, tools=[{"type": "google_search"}]
        )
    except Exception as e:
        print(f"Error calling Gemini API: {e}", file=sys.stderr)
        sys.exit(1)

    steps = interaction.steps or []

    if args.raw:
        raw_steps = []
        for step in steps:
            try:
                if hasattr(step, "model_dump"):
                    raw_steps.append(step.model_dump())
                elif hasattr(step, "dict"):
                    raw_steps.append(step.dict())
                else:
                    raw_steps.append(str(step))
            except Exception:
                raw_steps.append(str(step))
        print(json.dumps({"steps": raw_steps}, indent=2))
        return

    text_answers = []
    citations = []
    queries = []

    for step in steps:
        if (
            step.type == "google_search_call"
            and hasattr(step, "arguments")
            and step.arguments
        ):
            if hasattr(step.arguments, "queries") and step.arguments.queries:
                queries.extend(step.arguments.queries)
            elif isinstance(step.arguments, dict) and "queries" in step.arguments:
                queries.extend(step.arguments["queries"])

        elif step.type == "model_output" and hasattr(step, "content") and step.content:
            for content_block in step.content:
                if (
                    content_block.type == "text"
                    and hasattr(content_block, "text")
                    and content_block.text
                ):
                    text_answers.append(content_block.text)
                    if (
                        hasattr(content_block, "annotations")
                        and content_block.annotations
                    ):
                        for annotation in content_block.annotations:
                            if annotation.type == "url_citation":
                                start = getattr(annotation, "start_index", 0) or 0
                                end = getattr(annotation, "end_index", 0) or 0
                                cited_text = content_block.text[start:end]
                                citations.append(
                                    {
                                        "title": getattr(annotation, "title", "") or "",
                                        "url": getattr(annotation, "url", "") or "",
                                        "cited_text": cited_text,
                                        "start_index": start,
                                        "end_index": end,
                                    }
                                )

    full_text = "\n".join(text_answers)

    if args.json:
        out_data = {
            "query": args.query,
            "model": args.model,
            "queries_executed": queries,
            "answer": full_text,
            "citations": citations,
        }
        print(json.dumps(out_data, indent=2))
        return

    print(full_text)

    if citations:
        print("\n### Sources:")
        unique_sources = []
        source_map = {}

        for cit in citations:
            url = cit["url"]
            if url not in source_map:
                source_map[url] = len(unique_sources) + 1
                unique_sources.append(
                    {
                        "index": source_map[url],
                        "title": cit["title"],
                        "url": url,
                        "quotes": [],
                    }
                )
            if cit["cited_text"].strip():
                unique_sources[source_map[url] - 1]["quotes"].append(
                    cit["cited_text"].strip()
                )

        for src in unique_sources:
            print(f"\n[{src['index']}] **{src['title']}**")
            print(f"    URL: {src['url']}")
            if src["quotes"]:
                for quote in sorted(list(set(src["quotes"]))):
                    print(f'    * ... "{quote}" ...')


if __name__ == "__main__":
    main()
