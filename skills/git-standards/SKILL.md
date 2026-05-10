---
name: git-standards
description: |
  Git 操作规范 Skill。当用户提到以下关键词时触发：
  - 提交代码、提交变更、commit、git commit
  - 上传代码、推送代码、push、git push、上传 git
  - 合并代码、merge、pull request、PR、MR
  - 创建分支、切换分支、branch、checkout
  - 拉取代码、同步代码、git pull、git fetch
  - 回滚代码、撤销提交、revert、reset
  - 查看历史、git log、代码历史
  - 暂存改动、git stash
  以及任何涉及版本控制操作的场景。
---

# Git 操作规范

## ⚠️ 核心约束（最高优先级）

**严禁主动执行任何 git 操作。** 必须满足以下所有条件，才可执行 git 命令：

1. **用户明确指示**：用户明确说出"帮我提交"、"执行 push"、"现在 commit"等明确授权语句
2. **操作范围确认**：在执行前，向用户展示将要执行的命令清单，确认无误后方可执行
3. **禁止自动化**：不得在任何情况下"顺手"执行 git 操作，哪怕认为这对用户有利

> 如有任何不确定，先向用户确认，再执行。

---

## Commit Message 规范

### 格式（Angular 规范）

```
<type>(<scope>): <subject>

[body]

[footer]
```

| 部分 | 说明 | 是否必填 |
|------|------|----------|
| `type` | 变更类型（见下表） | ✅ 必填 |
| `scope` | 影响范围，如模块名、文件名 | 可选 |
| `subject` | 简短描述，不超过 50 字符，结尾不加句号 | ✅ 必填 |
| `body` | 详细说明，每行不超过 72 字符 | 可选 |
| `footer` | 关联 Issue、Breaking Change 说明 | 可选 |

### Type 类型

| Type | 用途 |
|------|------|
| `feat` | 新增功能 |
| `fix` | 修复 Bug |
| `docs` | 文档变更（README、注释等） |
| `style` | 代码格式调整（不影响逻辑，如空格、分号） |
| `refactor` | 代码重构（非新功能、非 Bug 修复） |
| `perf` | 性能优化 |
| `test` | 新增或修改测试 |
| `chore` | 构建过程、辅助工具变更（如 CI 配置、依赖升级） |
| `revert` | 回滚某次提交 |
| `build` | 影响构建系统或外部依赖的变更 |
| `ci` | CI/CD 配置文件变更 |

### Commit Message 模板

**简单提交（仅 header）：**
```
feat(auth): 新增用户登录功能
fix(api): 修复用户列表分页查询异常
docs(readme): 更新部署文档
```

**完整提交（含 body 和 footer）：**
```
feat(payment): 接入微信支付

- 新增微信支付下单接口
- 新增支付回调处理逻辑
- 添加支付状态查询功能

Closes #123
```

**Breaking Change 提交：**
```
refactor(api): 重构用户接口返回结构

旧结构：{ data: { user: {...} } }
新结构：{ user: {...} }

BREAKING CHANGE: 用户接口返回结构变更，需同步更新前端调用方
Closes #98
```

**回滚提交：**
```
revert: feat(auth): 新增用户登录功能

This reverts commit a1b2c3d4.
原因：登录功能存在安全漏洞，暂时回滚
```

---

## 分支命名规范

```
<type>/<描述>
```

| 类型 | 格式示例 | 用途 |
|------|----------|------|
| 主干分支 | `main` / `master` | 生产环境代码，禁止直接推送 |
| 开发分支 | `develop` | 日常集成分支 |
| 功能分支 | `feat/user-login` | 开发新功能 |
| 修复分支 | `fix/login-crash` | 修复 Bug |
| 发布分支 | `release/v1.2.0` | 版本发布准备 |
| 热修复分支 | `hotfix/payment-error` | 生产环境紧急修复 |

---

## 常用操作流程

### 标准功能开发流程

```bash
# 1. 从最新主干创建功能分支
git checkout main && git pull origin main
git checkout -b feat/your-feature

# 2. 开发完成后，暂存并提交
git add <文件>            # 建议指定文件，避免误提交
git status               # 确认暂存区内容
git commit -m "feat(模块): 描述"

# 3. 推送前拉取最新代码，解决冲突
git pull origin main --rebase

# 4. 推送分支
git push origin feat/your-feature
```

### 代码暂存（stash）

```bash
git stash                        # 暂存当前改动
git stash pop                    # 恢复暂存
git stash list                   # 查看所有暂存
git stash drop stash@{0}         # 删除指定暂存
```

### 撤销操作

```bash
# 撤销工作区修改（未 add）
git checkout -- <文件>

# 撤销暂存区（已 add，未 commit）
git reset HEAD <文件>

# 撤销最近一次提交（保留代码改动）
git reset --soft HEAD~1

# 回滚到指定提交（生成新 commit，安全）
git revert <commit-hash>
```

---

## 操作前必要确认清单

执行任何 git 写入操作前，需向用户确认以下内容：

- [ ] 当前所在分支是否正确？
- [ ] 改动文件列表（`git status`）是否符合预期？
- [ ] commit message 是否符合规范？
- [ ] 是否需要先拉取远程最新代码？
- [ ] push 的目标分支是否正确？

---

## 禁止事项

- ❌ 禁止 `git push --force` 到 `main`/`master` 分支
- ❌ 禁止未经用户确认直接执行 commit / push
- ❌ 禁止使用 `git add .` 或 `git add -A`（可能包含敏感文件），推荐指定文件
- ❌ 禁止跳过 pre-commit hook（`--no-verify`），除非用户明确要求
- ❌ 禁止在不了解影响的情况下执行 `git reset --hard`
