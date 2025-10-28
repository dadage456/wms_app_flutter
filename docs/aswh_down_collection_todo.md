# 自动化仓库在线拣选采集重构 TODO

- [x] 实现 `OnlinePickCollectionBloc`，串联初始化、扫码解析、缓存恢复与采集结果同步逻辑。
- [x] 构建 `OnlinePickCollectionPage`，复用通用扫码组件、信息卡片、数据表格与底部操作栏。
- [x] 新增 `OnlinePickCollectionResultPage`，支持列表展示、批量删除和结果回传。
- [x] 补充数据网格配置，统一任务行与采集记录表头。
- [x] 在 `AswhDownModule` 中注册 Bloc 与路由，完成采集页/结果页导航接入。
- [x] 为采集流程添加 Hive 缓存持久化，支持恢复未提交记录。
- [x] 对接提交出库、库存校验等后端接口，完善采集提交流程。
- [x] 补充 Bloc 与页面的单元/集成测试用例。
- [x] 根据业务反馈优化 UI 提示、异常处理与多模式切换。
