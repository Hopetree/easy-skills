# WXT 关键配置项说明

## wxt.config.ts 完整配置参考

```typescript
import { defineConfig } from 'wxt';

export default defineConfig({
  // 扩展模块
  modules: ['@wxt-dev/module-react'],

  // 输出目录
  outDir: 'dist',
  outDirTemplate: '扩展包名',            // 构建子目录名，与 package.json name 一致

  // Manifest 配置
  manifest: {
    name: '扩展名称',                    // 最长 45 字符
    description: '扩展描述',              // 最长 132 字符
    version: '0.0.1',                   // 由 tag 自动管理，不要手动修改

    // 权限声明 — 按最小权限原则
    permissions: [
      // 'storage',          // 本地存储
      // 'activeTab',        // 访问当前标签页
      // 'tabs',             // 标签页 API
      // 'scripting',        // 注入脚本
      // 'contextMenus',     // 右键菜单
      // 'sidePanel',        // 侧边栏
      // 'alarms',           // 定时任务
      // 'notifications',    // 系统通知
      // 'webRequest',       // 拦截/修改网络请求
      // 'cookies',          // Cookie 操作
    ],

    // 主机权限 — 按最小权限原则
    host_permissions: [
      // 'https://example.com/*',
      // '<all_urls>',       // 尽量避免，除非绝对必要
    ],

    // 后台脚本配置
    background: {
      // 默认使用 service_worker (MV3)
    },

    // 浏览器兼容性
    browser_specific_settings: {
      gecko: {
        id: 'your-extension@example.com',  // Firefox 需要
      },
    },

    // 图标（在 public/icons/ 目录下）
    icons: {
      16: 'icons/icon-16.png',
      48: 'icons/icon-48.png',
      128: 'icons/icon-128.png',
    },

    // 默认语言
    default_locale: 'zh_CN',

    // Web 可访问资源
    // web_accessible_resources: [
    //   {
    //     resources: ['injected.js'],
    //     matches: ['<all_urls>'],
    //   },
    // ],
  },

  // 构建配置
  // 参考: https://wxt.dev/api/config.html
});
```

## 常用入口类型

| 入口 | 目录路径 | 说明 |
|------|---------|------|
| Popup | `src/entrypoints/popup/` | 点击工具栏图标弹出 |
| Options | `src/entrypoints/options/` | 设置页面（全标签页） |
| Content Script | `src/entrypoints/content/` | 注入到网页的脚本 |
| Background | `src/entrypoints/background.ts` | Service Worker 后台脚本 |
| Side Panel | `src/entrypoints/sidepanel/` | 侧边栏面板 |
| DevTools | `src/entrypoints/devtools/` | 开发者工具面板 |
| New Tab | `src/entrypoints/newtab/` | 新标签页覆盖 |

## 注意事项

### 权限声明
- **最小权限原则**：只声明实际使用的权限
- Chrome Web Store 审核时，过多不必要的权限会导致拒绝或延迟
- `activeTab` 优于 `<all_urls>`（前者仅在用户点击扩展时生效）
- 开发阶段可以根据需要添加，提交审核前清理

### 版本管理
- **不要手动修改 version 字段**
- 通过 `git tag v1.2.3 && git push --follow-tags` 发布
- Release workflow 会自动同步版本到 package.json

### 图标
- 需要 PNG 格式
- 16×16、48×48、128×128 三个尺寸在模板中已包含占位图
- 开发前替换为实际图标
