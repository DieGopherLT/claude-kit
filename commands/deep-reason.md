---
description: Sequential thinking for complex problem-solving with hypothesis generation. Triggers: deep analysis, step by step, algorithm design, trade-offs, architectural decision, ultrathink
argument-hint: <problem>
model: opus
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
- When considering multiple approaches, use  `mcp__sequential-thinking__sequentialthinking` branches.

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
