# 技术栈详细说明

## 版本约束

| 包 | 版本范围 | 说明 |
|---|---------|------|
| wxt | ^0.19.0 | 浏览器扩展开发框架 |
| react | ^18.3.0 | UI 框架 |
| typescript | ^5.5.0 | 类型系统 |
| tailwindcss | ^3.4.0 | CSS 框架 |
| lucide-react | ^0.400.0 | 图标库（复杂插件使用） |
| vitest | ^2.0.0 | 测试框架 |
| eslint | ^9.0.0 | 代码检查 |
| prettier | ^3.3.0 | 代码格式化 |
| husky | ^9.0.0 | Git hooks 管理 |
| pnpm | >= 9 | 包管理器 |

## 选型理由

### WXT vs Plasmo vs 原生

| 维度 | WXT | Plasmo | 原生 MV3 |
|------|-----|--------|----------|
| 学习成本 | 中 | 中 | 高 |
| 开发体验 | 优秀（HMR） | 优秀 | 一般 |
| 框架支持 | React/Vue/Svelte/Vanilla | React | 不限 |
| 社区活跃度 | 高 | 高 | N/A |
| 打包工具 | Vite | Parcel | 自选 |
| 多浏览器支持 | 内置 | 内置 | 手动 |

选择 WXT 的原因：
1. 基于 Vite，与我们的测试框架 Vitest 生态统一
2. 支持多框架，不绑定特定前端库
3. HMR 开发体验好
4. 内置 .zip 打包命令，方便 CI/CD 集成

### Tailwind CSS v3 vs v4

选择 v3 的原因：
- v3 生态成熟，WXT 社区教程和示例更多
- PostCSS 配置方式与大多数项目一致
- v4 的 breaking changes 较多，部分社区配置未跟上

### Lucide vs Heroicons vs 其他

选择 Lucide 的原因：
- 图标数量多（1000+），覆盖绝大多数场景
- Tree-shakeable，按需引入不增加体积
- 风格现代统一
- 对 React 支持成熟

### 图标方案判断标准

**使用 Emoji 的场景（简单插件）**：
- 仅有一个 Popup 页面
- UI 极简（如：纯文本展示、单个开关按钮）
- 不需要列表、表格、菜单等复杂组件
- 总组件数 < 5

**使用 Lucide 的场景（复杂插件）**：
- 有 2+ 个页面（Popup + Options 等）
- 有 Content Script 注入
- 需要列表、表格、菜单、导航等组件
- 总组件数 >= 5

> 判断有歧义时，默认倾向 Emoji，保持简单。用户可覆盖选择。
