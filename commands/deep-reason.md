---
description: Advanced sequential thinking command for complex problem-solving through structured analysis.\n\n**When to use this command:**\n- Algorithmic problems requiring step-by-step decomposition\n- Architectural decisions with multiple trade-offs to evaluate\n- Complex debugging scenarios with non-obvious root causes\n- Trade-off analysis between competing solutions or approaches\n- Solution design requiring hypothesis generation and verification\n\n**What this command does:**\n- Uses the sequential thinking MCP tool to break down complex problems\n- Performs iterative analysis with the ability to revise and refine thoughts\n- Generates and verifies hypotheses systematically\n- Produces structured reasoning output in paper format\n- Optionally saves the complete analysis as a markdown file\n\n**Automatic invocation triggers:**\nThis command should be invoked when the user explicitly asks for deep analysis, systematic problem-solving, or mentions: "analyze thoroughly", "think step by step", "evaluate trade-offs", "debug complex issue", "architectural decision", "algorithm design", "ultrathink", "deep reasoning".\n\n**Arguments:**\nAccepts a problem description as argument. Example: `/deep-reason How should I implement caching for a distributed system with eventual consistency?`
---

# Deep Reasoning Analysis

You will analyze the following problem using systematic sequential thinking:

**Problem Statement:** $ARGUMENTS

## Process

You MUST use the `mcp__sequential-thinking__sequentialthinking` tool to solve this problem. Follow this structured approach:

1. **Initial Assessment**: Start with an estimate of complexity and required thought steps
2. **Decomposition**: Break the problem into manageable components
3. **Iterative Analysis**:
   - Analyze each component systematically
   - Question assumptions and revise as needed
   - Generate hypotheses when appropriate
4. **Hypothesis Verification**: Test and validate proposed solutions
5. **Synthesis**: Combine insights into a coherent solution
6. **Validation**: Ensure the solution addresses all aspects of the original problem

## Important Guidelines

- Express uncertainty when present - it's okay to revise your thinking
- Don't hesitate to add more thought steps if needed
- Mark thoughts that revise previous analysis
- Continue until you reach a satisfactory, well-reasoned solution
- Provide a clear, actionable answer as the final output

## Output Format

After completing the sequential thinking process, ask the user if they want to save the analysis as a markdown file in paper format.

If yes, use `AskUserQuestion` to determine:

1. **Language**: English or Spanish
2. **Customization**: If they want to modify the default paper structure

**Default paper structure:**

- Title based on the problem
- Abstract/Summary
- Problem Statement (original problem)
- Reasoning Process (all sequential thinking steps)
- Solution (highlighted final answer)
- Metadata (date, thought iterations count)

Then create the markdown file in the current working directory with a descriptive filename based on the problem (e.g., `deep-analysis-distributed-caching-YYYY-MM-DD.md`).

Allow the user to review and customize the structure before writing the file.
