# 队友复现故障排查：QEMU 卡住、Ctrl+Z 和清理

> 维护时间：2026-06-06（stage7a2）。
> 本文用于排查队友复现 integrated-labs 时的卡住问题；正式测试优先看 `docs/23_teammate_quickstart.md`。

## 1. apply + make 成功后不要继续等

运行：

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
```

如果已经看到：

```text
[OK] make completed successfully
```

说明 apply + make 阶段已经完成。它不是交互式 QEMU，不需要继续等待。后续可以运行：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

## 2. boot 和命令验证正常耗时

`boot-xv6.sh` 正常应在 1-2 分钟内返回；超过 5 分钟应按：

```text
Ctrl+C
```

不要用 `Ctrl+Z` 当退出方式。`boot-xv6.sh` 和 `run-xv6-command.sh` 都有 soft timeout、hard timeout 和 cleanup trap；如果仍卡住，按本文清理残留进程。

## 3. Ctrl+Z 不是退出

`Ctrl+C` = interrupt，表示中断前台命令。

`Ctrl+Z` = suspend，表示挂起前台命令；它不是退出。误按后可能把 `bash`、`timeout`、`make qemu` 或 `qemu-system-riscv64` 留在后台，下一次复现就可能继续卡。

## 4. 推荐清理命令

优先使用仓库脚本：

```bash
bash scripts/xv6/cleanup-qemu.sh
```

它会先列出相关进程，再执行 rescue-level `pkill` 清理，最后再次列出剩余进程。注意：`pkill` 可能影响同一 WSL 实例里的其他 xv6/QEMU 运行。

如果你在同一个 shell 里误按过 `Ctrl+Z`，也可以手工检查 job：

```bash
jobs -l
kill %1
```

如果 job 编号不是 `%1`，按 `jobs -l` 显示的实际编号修改。

救援级手工命令如下：

```bash
pkill -f qemu-system-riscv64 || true
pkill -f "make qemu" || true
```

清理后可检查：

```bash
pgrep -af 'qemu-system-riscv64|make.*qemu' || echo "(OK: no qemu/make qemu process)"
```

## 5. 如何继续复现

第一次正式复现：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

已经 make 成功后的二次重测：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

如果机器较慢，或仓库在 `/mnt/d` 下首次 boot 较慢，可临时提高 timeout：

```bash
XV6_BOOT_TIMEOUT_SECONDS=90 XV6_BOOT_RETRIES=2 XV6_COMMAND_TIMEOUT_SECONDS=90 XV6_COMMAND_RETRIES=2 bash scripts/xv6/teammate-verify.sh --quick
```

成功必须来自脚本在真实 QEMU 日志里匹配到预期输出，不能手写或伪造。

## 6. 反馈给队长

优先复制 `teammate-verify.sh` 最后打印的：

```text
COPY THIS SUMMARY TO TEAM LEAD
...
END SUMMARY
```

也可以复制对应 summary 文件内容：

```text
logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt
```

失败时请补充：

- 运行的是 `--full` 还是 `--quick`；
- 是否看到 `[OK] make completed successfully`；
- 是否按过 `Ctrl+Z`；
- 是否运行过 `cleanup-qemu.sh`；
- 失败步骤附近的终端输出；
- 当前目录是否在 `/mnt/` 下。

## 7. 安全边界

- 不提交 `external/xv6-riscv/`。
- 不提交 `logs/*.log`。
- 不提交 `logs/teammate-verify-*.summary.txt`。
- 不发 token、密码、cookie、报名材料或隐私截图。
- 不把 timeout 自动捕获说成人工交互录屏。
- 不把失败结果改写成成功。
