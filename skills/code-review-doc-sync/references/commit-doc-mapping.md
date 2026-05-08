# Commit 类型与文档影响速查表

## 按 Conventional Commits 类型

| Commit 类型 | 含义 | 高概率影响文档 | 低概率影响文档 |
|------------|------|-------------|-------------|
| `feat` | 新功能 | PRD（验收标准）、API、SDD | 项目计划 |
| `fix` | 修复 bug | SDD（如涉及流程修正） | API（如修复接口行为） |
| `refactor` | 重构 | TDD（架构调整）、SDD | ERD |
| `perf` | 性能优化 | SDD | TDD |
| `chore` | 构建/工具变更 | TDD（依赖、部署方式） | — |
| `docs` | 文档更新 | 直接就是文档变更，无需额外同步 | — |
| `test` | 测试代码 | 通常无需更新设计文档 | — |
| `ci` | CI/CD 变更 | TDD（部署架构） | — |
| `build` | 构建系统 | TDD | — |
| `migration` | 数据迁移 | ERD | SDD |

---

## 按变更文件路径

### 后端路径特征

| 路径特征 | 示例 | 影响文档 |
|---------|------|---------|
| `routes/`、`router/` | `routes/user.js` | API |
| `controllers/`、`handlers/` | `controllers/AuthController.php` | API |
| `models/`、`entities/` | `models/User.py` | ERD |
| `migrations/`、`schema/` | `migrations/001_add_avatar.sql` | ERD |
| `services/`、`domain/` | `services/PaymentService.java` | SDD |
| `middleware/` | `middleware/auth.go` | API（认证说明）、SDD |
| `config/`、`configs/` | `config/database.yaml` | TDD |
| `Dockerfile`、`docker-compose*` | `docker-compose.yml` | TDD |
| `nginx*`、`*.conf` | `nginx.conf` | TDD |

### 前端路径特征

| 路径特征 | 示例 | 影响文档 |
|---------|------|---------|
| `pages/`、`views/` | `pages/Dashboard.tsx` | PRD（功能说明）、SDD |
| `components/` | `components/UserCard.vue` | SDD |
| `api/`、`services/` | `api/userApi.ts` | API |
| `store/`、`redux/`、`vuex/` | `store/authSlice.ts` | SDD |
| `router/` | `router/index.ts` | SDD |

### 通用

| 路径特征 | 示例 | 影响文档 |
|---------|------|---------|
| `README.md` | — | 通常用户自行维护 |
| `.env.example` | — | TDD（环境变量说明） |
| `package.json`、`go.mod`、`pom.xml` | 依赖变更 | TDD（技术选型） |

---

## 不需要更新文档的变更

以下变更通常不影响设计文档，可跳过：
- 纯样式调整（CSS、SCSS）
- 测试文件变更（`*.test.*`、`*.spec.*`、`__tests__/`）
- 代码格式化（仅空白符、换行变更）
- 依赖版本的小版本 / patch 升级
- `.gitignore`、`.editorconfig` 等编辑器配置

---

## 文档更新的颗粒度建议

| 文档 | 最小更新单位 | 示例 |
|------|------------|------|
| API 文档 | 接口级别 | 新增一个接口条目 / 修改某个字段说明 |
| ERD | 表/字段级别 | 新增一张表 / 在已有表中新增字段 |
| TDD | 模块/章节级别 | 更新技术选型章节 / 新增模块说明 |
| SDD | 流程/模块级别 | 更新某业务流程图 / 新增模块接口说明 |
| PRD | 功能条目级别 | 新增一条用户故事 / 更新验收标准 |
| 项目计划 | 任务/里程碑级别 | 标记任务完成 / 调整日期 |
