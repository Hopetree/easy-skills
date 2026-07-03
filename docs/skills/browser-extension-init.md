# browser-extension-init

浏览器插件项目初始化 Skill。

## 使用场景

- 创建浏览器插件、新建浏览器扩展、初始化插件项目
- 写一个 Chrome 扩展、做浏览器插件开发
- WXT 项目初始化、浏览器插件脚手架
- 任何涉及创建浏览器插件项目的场景

## 核心功能

基于 **WXT + React + Tailwind CSS** 标准技术栈，一键生成浏览器插件项目脚手架，包含：

1. **交互式需求收集**：引导用户确认插件名称、功能描述、所需模块（Popup、Options、Content Script、右键菜单、Side Panel、DevTools）
2. **智能图标方案选择**：根据复杂度自动推荐 emoji（简单插件）或 Lucide 图标库（复杂插件），确保风格统一
3. **标准化模板生成**：从模板复制项目结构，自动替换占位符（名称、描述、版本号等）
4. **CI/CD 就绪**：内置 GitHub Actions 工作流（CI 检查 + Release 自动发布），版本号由 Git tag 驱动
5. **代码规范配套**：预配置 ESLint、Prettier、Husky、TypeScript 类型检查
6. **一键安装**：自动执行 `pnpm install`、初始化 Git 仓库、配置 Husky hooks

生成后项目即可直接 `pnpm dev` 启动开发。
