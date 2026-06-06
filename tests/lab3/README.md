# lab3 测试记录

> 维护时间：2026-06-06（stage9b）。

## 当前测试目标

验证 independent Lab3 `pgcount()` 页表观察 patch：

- eager `sbrk(2 * PGSIZE)` 后已映射用户页数量增加 2。
- lazy `sbrklazy(2 * PGSIZE)` 触摸前不增加映射页数量。
- 触摸 lazy 区域两页后映射页数量增加 2。
- `pgcounttest` 正常结束。

## 测试命令

```bash
bash scripts/xv6/check-xv6-baseline.sh
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch
make
cd ../..
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount eager delta = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta before touch = 0"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta after two touches = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"
```

## 真实结果

| 测试项 | 结果 |
| --- | --- |
| baseline check | PASS |
| clean baseline reset/apply | PASS |
| `make` | PASS |
| `pgcount eager delta = 2` | PASS |
| `pgcount lazy delta before touch = 0` | PASS |
| `pgcount lazy delta after two touches = 2` | PASS |
| `pgcounttest done` | PASS |

## 证据边界

- 原始 QEMU logs 在 `logs/` 下，Git ignored，不提交。
- `pgcount before/after` 的绝对数值不固定，不作为验收标准。
- 本测试只覆盖 independent Lab3 patch，不覆盖 integrated `0006`，也不代表队友已经复现 Lab3。
