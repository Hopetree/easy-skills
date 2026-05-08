# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Claude Code skills collection** — a repo of reusable skills for AI-assisted development. Each skill lives in its own directory under `skills/` as a `SKILL.md` file with YAML frontmatter (name, description) followed by Markdown instructions.

## Architecture

- **Skills are standalone**: Each skill directory contains a `SKILL.md` (entry point) and optional `references/` subdirectory with supplementary Markdown files.
- **No build system, no tests, no dependencies** — this repo is purely Markdown content.
- Skills are written in **Chinese (中文)** as the primary language.

## Skills in This Repo

- **`code-review-doc-sync`** — Git commit review + project document sync. Reviews code diffs, generates a review report, identifies which project documents (PRD, TDD, ERD, API, SDD) are affected, and updates them after user confirmation. Maintains state in `docs/review-state.json`.
- **`project-init-docs`** — Project document initialization. Guides collaborative creation of project design documents (PRD, TDD, ERD, API, SDD, project plan) in `docs/design/`. Documents are written in Chinese using numbered naming (e.g., `01_PRD_产品需求规格说明书.md`).

## Conventions for Adding/Editing Skills

- Every skill directory must contain a `SKILL.md` with YAML frontmatter (`name`, `description`).
- The `description` field in frontmatter should include trigger keywords so the skill host can auto-discover it.
- Keep supporting material in `references/` — the main `SKILL.md` should contain the core workflow.
- Write skill content in Chinese unless the context demands English.
- When updating a skill, preserve the structured workflow format (numbered steps, tables, code blocks).
