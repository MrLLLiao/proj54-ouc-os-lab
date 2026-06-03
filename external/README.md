# external/ 第三方源码管理目录

本目录用于**隔离管理**第三方源码（首要为 xv6-riscv baseline），使其与本队自有代码、文档物理分离。

> 当前状态：TODO / 待队长确认引入方式。本目录现在**只有本说明文件**，尚未引入任何第三方源码。

## 1. 第三方源码管理原则

- 第三方源码**不直接复制混入**本仓库的自有代码区，统一放在 `external/`。
- 引入任何第三方源码前，必须先完成 [../docs/08_reference_and_license.md](../docs/08_reference_and_license.md) 的“许可证检查清单”。
- 原样保留上游 LICENSE 与源文件版权头，不改写版权人，不对第三方代码主张本队版权。
- `external/` 下的 baseline 源码工作树**默认不提交**（见仓库根 `.gitignore`），避免误把第三方源码推入官方 GitLab。
- 记录准确的来源 URL 与 commit/tag，保证可审计、可复现。

## 2. 当前计划引入的 baseline

- 名称：xv6-riscv（教学型类 Unix 内核，RISC-V）
- 计划上游：`https://github.com/mit-pdos/xv6-riscv`（待队长核对并登记）
- 预计许可证：MIT（**待核验**）
- 计划路径：`external/xv6-riscv`
- 方案与对比详见 [../docs/11_xv6_baseline_plan.md](../docs/11_xv6_baseline_plan.md)

## 3. 为什么不直接把第三方源码混入仓库

- 避免版权归属混淆：自有产出与上游代码必须可清晰区分。
- 避免仓库体积膨胀与更新困难。
- 避免“把他人代码当作自有成果”的合规与诚信风险。
- 便于评委审计：来源与版本一目了然。

## 4. 后续引入方式（命令占位，需队长授权后在 WSL2 Ubuntu 执行）

### 方式 B：git submodule（推荐，钉死 commit）

```bash
# 在仓库根目录
git submodule add https://github.com/mit-pdos/xv6-riscv external/xv6-riscv
cd external/xv6-riscv && git checkout <选定的commit> && cd -
git submodule status        # 记录 commit
# 然后把 URL、commit、LICENSE 登记到 docs/08
```

> 使用 submodule 后，克隆需带 `--recursive`，或克隆后执行：
>
> ```bash
> git submodule update --init --recursive
> ```

### 方式 D：手动 / 脚本下载到不提交的 external/（备选）

```bash
# 手动 clone（不会被提交，因为 .gitignore 已忽略 external/ 下的子目录）
git clone https://github.com/mit-pdos/xv6-riscv external/xv6-riscv
cd external/xv6-riscv && git checkout <选定的commit> && cd -
```

> 选择此方式时，应在本文件补充“固定 commit + 校验方式”，保证可复现。

## 5. 许可证记录入口

所有第三方来源与许可证统一登记在：[../docs/08_reference_and_license.md](../docs/08_reference_and_license.md)。

## 6. 当前状态

- [x] 已建立 `external/` 隔离目录与管理说明。
- [ ] 待队长确认引入方式（submodule 优先，external 下载备选）。
- [ ] 待核对上游 URL 与许可证并登记 `docs/08`。
- [ ] 待在 WSL2 Ubuntu 安装工具链并真实构建（见 `docs/11` 第 6-8 节）。
