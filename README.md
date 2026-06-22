# easy-skills

Claude Code 技能（Skills）合集，提供可复用的 AI 辅助开发工作流。

## 技能列表

### project-init-docs — 项目文档初始化

```
了解项目 ──> 评估文档清单 ──> 用户确认范围 ──> 逐文档协作撰写 ──> 生成项目 README.md
    │                                                   │                │
    │                                                   ▼                │
    │                                           写入 docs/design/       │
    │                                                   │                │
    └────────────── 注册到 review-state.json ◄──────────┴────────────────┘
```

根据项目描述智能评估所需文档范围，与用户确认后协作撰写，输出到 `docs/design/` 目录。全部设计文档完成后自动生成项目 `README.md`（含文档索引表）。支持 PRD、TDD、ERD、API、SDD、项目计划等文档类型。

### code-review-doc-sync — 代码审查 + 文档同步

```
确定 review 范围 ──> 代码 Review ──> 输出报告到 docs/code-review.md（面向 AI 的可执行修改指令）
                                      │
                                      ▼
                              加载文档注册表（review-state.json）
                                      │
                                      ▼
                              分析代码变更对文档的影响
                                      │
                                      ▼
                              逐文档确认并更新 ──> 写入变更记录
                                      │
                                      ▼
                              更新 review-state.json
```

支持两种使用方式：

**Review 模式**（默认）：读取 git 提交差异进行代码审查，输出 review 报告到 `docs/code-review.md`（面向 AI 阅读，包含精确的修改位置和修改代码），然后识别受影响的项目文档并提出更新建议，经确认后写入文档。通过 `docs/review-state.json` 跨会话记忆上次 review 位置。

**`--fix` 模式**：读取已有的 `docs/code-review.md` 报告，按优先级逐项修复代码问题，每修复一项自动更新报告中的状态（`⏳ 待处理` → `✅ 已修复`）。

```
读取 code-review.md ──> 解析待处理问题 ──> 逐项修复代码 ──> 更新报告状态 ──> 汇总
```

### git-standards — Git 操作规范

Git 操作规范约束。禁止 AI 主动执行 git 命令，必须在用户明确指示且确认操作范围后才可执行。规范涵盖 commit message 格式（Angular 规范）、分支命名、常用操作流程和禁止事项。

## 安装

```
skills/
  <skill-name>/
    SKILL.md              # 技能定义（YAML frontmatter + Markdown）
    references/           # 参考资料（可选）
```

## 使用方式

```bash
make install     # 安装所有 skills 到 ~/.claude/skills/
make <skill名>   # 安装单个 skill
make list        # 查看可安装的 skills
make clean       # 清理已安装的 skills
```

安装后技能会根据触发关键词自动匹配执行。

- [ai-delivery-spec](https://github.com/franklinxkk/ai-delivery-spec) — Spec-driven delivery framework for product managers — 4 delivery tiers, 0D triage, prototype testability, AI runtime governance, 5 domain modules
