---
name: browser-extension-init
description: |
  浏览器插件项目初始化 Skill。当用户提到以下关键词时触发：
  - 创建浏览器插件、新建浏览器扩展、初始化插件项目
  - 写一个 Chrome 扩展、做浏览器插件开发
  - WXT 项目初始化、浏览器插件脚手架
  以及任何涉及创建浏览器插件项目的场景。
---

# 浏览器插件项目初始化 Skill

## 核心原则

**标准化优先**：所有生成的插件项目使用统一的技术栈和工程规范，确保代码风格、CI/CD、图标方案保持一致。

**图标统一**：简单插件使用 emoji 做图标，复杂插件使用 Lucide 图标库，**两者不能混用**。

**版本单一真理源**：Git tag = 扩展版本号 = package.json version = manifest version，由 tag 驱动自动同步。

---

## 工作流程

### 第一阶段：了解需求

向用户提问，一次一个问题，了解以下信息：

1. **插件名称**：中英文均可，会用于 package.json 的 name 字段和扩展 manifest 的 name
2. **功能描述**：用户用 2-3 句话描述插件要做什么
3. **所需功能模块**（多选）：
   - Popup（弹出窗口，点击工具栏图标弹出）
   - Options（设置页面，右键图标 → 选项）
   - Content Script（注入网页的脚本）
   - 右键菜单（Context Menu）
   - Side Panel（侧边栏面板，Chrome 114+）
   - DevTools（开发者工具面板）

### 第二阶段：判断复杂度与图标方案

根据功能模块数量，按以下规则判断复杂度：

| 条件 | 复杂度 | 图标方案 |
|------|--------|----------|
| 仅 Popup + 极简交互（如纯文字、一个按钮） | 简单 | **Emoji** |
| 有 2+ 个页面，或多组件多状态 | 复杂 | **Lucide + Lucide React** |

**判断后必须向用户确认**：

```
根据您的描述，这个插件属于 [简单/复杂] 类型：
- 原因：xxx
- 图标方案建议：使用 [emoji / Lucide 图标库]

是否同意？如需调整请说明。
```

**确认后再进入生成阶段。**

---

### 第三阶段：确认并生成项目

汇总所有确认信息，向用户展示：

```
即将创建插件项目，确认以下信息：

| 项目 | 内容 |
|------|------|
| 插件名称 | xxx |
| 复杂度 | 简单 / 复杂 |
| 图标方案 | Emoji / Lucide |
| 功能模块 | Popup, Options, Content Script |

确认后开始生成？
```

用户确认后开始生成。

---

### 第四阶段：生成项目文件

项目从 `assets/template/` 复制标准模板，并进行变量替换。

#### 4.1 复制模板

```bash
cp -r <skill-dir>/assets/template/ <目标项目目录>/
```

#### 4.2 变量替换

在复制后的文件中执行以下替换：

| 占位符 | 替换为 | 示例 |
|--------|--------|------|
| `{{EXTENSION_NAME}}` | 扩展名称 | "我的工具" |
| `{{EXTENSION_DESCRIPTION}}` | 扩展描述 | "一个提高效率的浏览器工具" |
| `{{PACKAGE_NAME}}` | 小写连字符包名 | "my-tool" |
| `{{EXTENSION_VERSION}}` | 初始版本 | "0.0.1" |
| `{{ICON_MODE}}` | `emoji` 或 `lucide` | "emoji" |

**替换范围**：
- `package.json` — `{{EXTENSION_NAME}}`、`{{PACKAGE_NAME}}`、`{{EXTENSION_VERSION}}`、`{{EXTENSION_DESCRIPTION}}`
- `wxt.config.ts` — `{{EXTENSION_NAME}}`、`{{EXTENSION_DESCRIPTION}}`
- `README.md` — `{{EXTENSION_NAME}}`、`{{EXTENSION_DESCRIPTION}}`
- `.github/workflows/ci.yml` — 无需替换
- `.github/workflows/release.yml` — 无需替换

#### 4.3 图标方案处理

**Emoji 模式**：
- 不安装 `lucide-react`
- 从 `package.json` 移除 `lucide-react` 依赖
- popup/options 等页面的 App.tsx 使用 emoji 作为图标占位符

**Lucide 模式**：
- 保留 `lucide-react` 依赖
- popup/options 等页面的 App.tsx 使用 Lucide 图标组件
- 在 `globals.css` 中保留 Lucide 相关样式

#### 4.4 安装依赖

```bash
cd <目标项目目录>
pnpm install
```

#### 4.5 初始化 Git

```bash
cd <目标项目目录>
git init
git add -A
git commit -m "chore(init): 初始化浏览器插件项目 {{EXTENSION_NAME}}

使用 WXT + React + Tailwind CSS 技术栈
图标方案: {{ICON_MODE}}"
```

#### 4.6 初始化 Husky

```bash
cd <目标项目目录>
pnpm exec husky init
```

---

### 第五阶段：配置 GitHub

生成完成后，提示用户配置 GitHub：

1. **创建 GitHub 仓库**（如果尚未创建）
2. **推送代码**：
   ```bash
   git remote add origin <repo-url>
   git push -u origin main
   ```
3. **配置 Actions 权限**：确保仓库 Settings → Actions → General → "Read and write permissions" 已启用
4. **配置 Workflow permissions**：确保 "Allow GitHub Actions to create and approve pull requests" 已启用（Release 工作流需要自动提交版本更新）

---

### 第六阶段：使用说明

项目生成后，向用户说明：

```
✅ 项目已生成！

## 日常开发
pnpm dev          # 启动开发模式（热重载）
pnpm build        # 生产构建
pnpm zip          # 打包为 .zip

## 代码检查
pnpm type-check   # TypeScript 类型检查
pnpm lint         # ESLint 检查
pnpm format       # Prettier 自动格式化
pnpm test         # 运行测试

## 发布新版本
1. git checkout main && git pull
2. npm version patch/minor/major   # 或手动打 tag
3. git push --follow-tags
4. GitHub Actions 自动构建并发布到 Release

## 加载到浏览器
1. 打开 chrome://extensions/
2. 开启「开发者模式」
3. 点击「加载已解压的扩展程序」
4. 选择项目的 dist/chrome-mv3 目录（开发模式）
```

---

## 图标方案切换

项目创建后如需切换图标方案，按以下步骤操作：

**从 Emoji 切换到 Lucide**：
1. `pnpm add lucide-react`
2. 将各页面中的 emoji 替换为对应的 Lucide `<Icon>` 组件
3. 确保 emoji 图标和 Lucide 图标不同时存在

**从 Lucide 切换到 Emoji**：
1. `pnpm remove lucide-react`
2. 移除各页面中 `import { X } from 'lucide-react'` 的引用
3. 将 `<XIcon />` 替换为对应的 emoji 字符
4. 清理导入语句

---

## 注意事项

- **图标不能混用**：一个插件中只能出现 emoji 或 Lucide 图标中的一种
- **不要手改版本号**：版本号由 tag 自动管理，直接打 tag 推送即可
- **首次推送后检查 GitHub Actions**：确保 CI 和 Release 工作流正常运行
- **WXT 版本**：模板使用 WXT 最新稳定版，如用户需要特定版本，在生成前确认
- 所有生成的配置文件均可后续按需调整，skill 只负责初始化标准模板
