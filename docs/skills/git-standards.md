# git-standards

Git 操作规范 Skill。

## 使用场景

- 提交代码、commit、git commit
- 推送代码、push、git push
- 合并代码、merge、pull request、PR、MR
- 创建/切换分支、branch、checkout
- 拉取/同步代码、pull、fetch
- 回滚代码、撤销提交、revert、reset
- 查看代码历史、git log
- 暂存改动、git stash
- 任何涉及版本控制操作的场景

## 核心功能

1. **Commit Message 规范**：强制执行 Angular 规范格式（`type(scope): subject`），定义 11 种 type 类型（feat、fix、docs 等），提供简单/完整/Breaking Change/回滚四种模板
2. **分支命名规范**：标准化分支命名（`feat/xxx`、`fix/xxx`、`release/vx.x.x`、`hotfix/xxx`），禁止直接推送到 main/master
3. **标准化操作流程**：提供功能开发、代码暂存（stash）、撤销操作（reset、revert、checkout）等常见场景的完整命令序列
4. **安全约束**：禁止 force push 到主干分支、推荐指定文件 add 避免误提交、禁止跳过 pre-commit hook
5. **直接执行**：用户明确下达指令时直接执行，仅在高风险操作（force push、reset --hard、删除分支等）时确认
