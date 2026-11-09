# Report findings with an AI

When you test Automated Packaging, an AI can help you write down what you find. It asks you
questions, collects evidence, and writes your findings in a format that the product team can use
directly. You send the findings to the team.

There are two ways. Use the first one if your AI tool can read and write files.

=== "AI with file access"

    For AI tools that work in a folder, for example Claude Code or Google Antigravity.

    1. Download the [tester kit](downloads/automated-packaging-tester-kit.zip).
    2. Extract it to a folder of its own, for example `C:\TesterKit`. Do not put it in the
       working directory of the product.
    3. Open the `tester-kit` folder in your AI tool as the workspace.
    4. Paste this as your first message:

        ```{.text .wrap}
        Read AGENTS.md and follow it. Start a findings session.
        ```

    The AI writes one file for each day and build into the `findings` folder, for example
    `2026-11-03-v0.2.32.md`.

=== "Chat AI"

    For AI tools that only chat, but can open a web page.

    1. Paste this as your first message:

        ```{.text .wrap}
        Read https://docs.appventix.com/AutomatedPackaging/tester-kit-instructions/ and follow the instructions on it. Start a findings session.
        ```

    2. At the end of the session, the AI gives you the file of the day as one Markdown block,
       with its name above it. Save it with that name, for example `2026-11-03-v0.2.32.md`, in a
       folder called `findings`.

    If your AI cannot open web pages, open
    [Instructions for the AI](tester-kit-instructions.md), copy all the text, and paste it as your
    first message.

## During the session

The AI first asks who you are, which build you test, and what you test today. The build number
is in the title bar of the application, after "Automated Packaging".

Then test. Each time you notice something, tell the AI in your own words, for example:

```{.text .wrap}
Finding: on the Workers screen, Update stopped after 20 minutes with AP-HV-006.
```

The AI asks for what is still missing, one question at a time. It shows you each finding before
it writes it.

If the AI is connected to the product through MCP, it can read the job log and the error code to
add evidence. It uses only tools that read. See [AI agents (MCP)](mcp.md).

When you are finished, type:

```{.text .wrap}
I am finished for today. Close the session.
```

## Send your findings

1. Open each file in `findings` and read it. Make sure that it holds no computer names, user
   names, passwords or licence keys. The AI removes them, but check.
2. Crop each screenshot to the part that matters.
3. Make a zip file of the `findings` folder, and send it as your tester invitation says.
