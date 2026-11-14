---
name: gemini-google-search
description: Do a google search via gemini api
---

# Prerequisites

- $GEMINI_API_KEY environment variable defined
- `uv` installed

# Command Execution

Run a search with `uv` directly:

```bash
uv run search.py "query string"
```

Sometimes it takes a while. Be patient. Set a generous timeout.
Default llm isn't the smartest.

# Options

- `--json`: Output a clean, parsed JSON structure with the answer, executed search queries, and citation URLs.
- `--raw`: Output the complete raw JSON step sequence from the Gemini interactions API.
- default output is markdown with a "Sources" section
