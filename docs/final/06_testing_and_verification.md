# 06 Testing and Verification

## 测试原则

- 只记录真实执行过的命令和结果。
- 原始日志和 summary 默认在 `logs/` 下，Git 忽略，不提交。
- timeout 自动捕获不等于长期稳定性测试。
- 队长本机验证不等于队友独立复现。
- 不固定 `pcount(RUNNING)`、`fcount(...)` 数字或 `pchildtest` 状态。

## 测试覆盖表

| 测试项 | 覆盖内容 | 命令 | 预期结果 | 当前真实结果 | 证据位置 |
| --- | --- | --- | --- | --- | --- |
| doctor | 环境、工具链、baseline、ignored logs、QEMU 残留 | `bash scripts/xv6/doctor.sh` | `READY` 或 `READY WITH WARNINGS`；缺关键工具非 0 | PASS；`riscv64-unknown-elf-gcc` 和 `/mnt/` 可 WARN | `docs/06_progress_log.md`，ignored summary/logs |
| baseline build | clean xv6 baseline 构建 | `bash scripts/xv6/check-xv6-baseline.sh --make` | make 成功 | PASS | `external/xv6-baseline-record.md`，`docs/04_test_report.md` |
| boot | xv6 启动关键文本 | `bash scripts/xv6/boot-xv6.sh` | `BOOT_EVIDENCE_FOUND`，匹配 `xv6 kernel is booting` 和 `init: starting sh` | PASS | `docs/04_test_report.md`，ignored `logs/xv6-boot-*.log` |
| hello | lab1 `hello()` syscall | `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"` | 匹配指定文本 | PASS | `docs/04_test_report.md` |
| add2test | lab1 `add2(int,int)` syscall | `bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"` | 匹配指定文本 | PASS | `docs/14_lab1_argint_extension_review.md`，`docs/04_test_report.md` |
| pstatetest | lab2 `pstate(int pid)` | `bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="` | 匹配前缀 | PASS | `docs/15_lab2_process_observation_review.md`，`docs/04_test_report.md` |
| pcounttest | lab2 `pcount(int state)` 正常和负向输入 | `bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="`；`bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"` | 匹配前缀和 invalid state `-1` | PASS；数值不固定 | `docs/19_lab2_v0.2_process_observation_review.md` |
| pchildtest | lab2 子进程状态观察 | `bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="` | 匹配前缀；状态不固定 | PASS | `docs/19_lab2_v0.2_process_observation_review.md` |
| pgcounttest | lab3 页表映射数量观察；eager/lazy allocation 对比 | `bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount eager delta = 2"`；`bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta before touch = 0"`；`bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta after two touches = 2"`；`bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"` | 匹配真实计算出的 delta 和完成标记 | PASS；independent patch only，未 integrated，未队友复现 | `tests/lab3/README.md`，`patches/lab3-memory-and-pagetable/README.md` |
| fcounttest | lab4 文件表观察 | `bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"` | 匹配 `fcounttest done`；可选检查 before/open/close 前缀 | PASS；数字不固定 | `docs/20_lab4_file_table_observation_review.md` |
| local-verify | 队长本机预检 | `bash scripts/xv6/local-verify.sh --quick` 或 `--full` | copy-to-lead summary overall PASS | 队长本机 local/full PASS；summary 在 ignored logs | `docs/06_progress_log.md`，`logs/teammate-verify-*.summary.txt` ignored |
| teammate-verify | 队友正式复现入口 | `bash scripts/xv6/teammate-verify.sh --full` | 队友机器 summary overall PASS | 已收到 2 份队友 full verification PASS summary；原始 logs/summary/截图不入仓；真实姓名/系统版本待补充 | `submissions/teammate_reproduction_record.md`，`docs/23_teammate_quickstart.md` |
| manual xv6 shell demo | 人工进入 xv6 shell 运行 hello/add2/pstate/pcount/pchild/fcount | `cd external/xv6-riscv && make qemu` 后手动输入用户程序 | 真实 shell 输出，不依赖 timeout 自动捕获 | 已录制 3 段视频；文件名和约略大小已记录，时长和平台提交方式待补充 | `submissions/demo_record.md` |

## 一键验证路径

第一次正式复现：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

已 make 成功后的重测：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

队长录屏前：

```bash
bash scripts/xv6/local-verify.sh --quick
```

## 失败处理

```bash
bash scripts/xv6/cleanup-qemu.sh
```

如果同一个 shell 里误按过 `Ctrl+Z`，还需要：

```bash
jobs -l
kill %1
```

## 证据边界

- summary 和 raw logs 不提交 Git。
- 脚本 PASS 必须来自真实日志匹配，不从 expected text 标题中伪匹配。
- `apply-integrated-labs.sh --make --yes` 打印 `[OK] make completed successfully` 才表示 make 阶段完成。
- manual video 与 timeout evidence 分开记录。
- 队友复现记录只保存文字摘要；原始 logs、summary 文件和截图不入仓。
- Lab3 当前只验证 independent patch；未进入 integrated-labs，也未进入 teammate full workflow。
