## Repository polish for ANTS revision — 2026-05-07


Validation experiments that required Magma or PARI/GP were run on `lehner`, a University of Warwick machine.

### Work log

- Added a standard-library-only `run_examples.py` driver with `smoke`, `split`, `simple`, `core`, `stoll`, and `rootnumber-gp` tasks.
- Replaced the README with concise setup and reproducibility instructions and moved the detailed inventory into `FILES.md`.
- Added `COMPUTATIONAL_ENVIRONMENT.md` and `.gitignore`.
- Added short headers to the Magma and PARI/GP files, keeping formulas, curve equations, and rank statements unchanged.
- Made `HighRankSimpleJacobianExamples.m` and `StollStats.m` write to an optional `OUTPUT_FILE` so the driver does not overwrite tracked logs.
- Repaired `Elkies29gen2.m` conservatively by removing the unfinished helper and loop, leaving only `f`, `C`, and `xs`.
- Updated `utils.m` so `CurveToRankAndHeight` asserts rational square values with `IsSquare` before constructing points from `xs`.
- Added a README documentation note disclosing that the Python driver and documentation polish were prepared with assistance from GPT-5.5 (OpenAI Codex).

### Validation

- Python version recorded: `Python 3.14.2`.
- Magma version on `lehner`: `V2.29-7`.
- PARI/GP version on `lehner`: `GP/PARI CALCULATOR Version 2.17.2 (released)`.
- `python3 -m py_compile run_examples.py` — succeeded.
- `python3 run_examples.py --list` — succeeded.
- `python3 run_examples.py --task smoke` — succeeded on `lehner` with Magma V2.29-7; printed `RootNumber(a)` for `a = 1,...,10`.
- `python3 run_examples.py --task split` — succeeded on `lehner` with Magma V2.29-7; printed both split-Jacobian examples and degree/binary-size estimates.
- `python3 run_examples.py --task simple` — succeeded on `lehner` with Magma V2.29-7 in 425.77 seconds; wrote all five Appendix A.1 summary rows to `Families-list.log`.
- `python3 run_examples.py --task rootnumber-gp` — succeeded on `lehner` with PARI/GP 2.17.2; the saved output includes PARI warnings about unknown conductor valuation at 2 and a final timing value.
- `python3 run_examples.py --task stoll --m 1` — run on `lehner` for the eight-hour validation cap; it produced a partial `stoll-1.log` with 73 candidate lines before the timeout stopped the still-running Magma computation.
- The long runtime is due to the script's repeated rational-point searches and mostly due to the expensive `MordellWeilGroup(J)` computations for selected Jacobians.

### Files changed

- `.gitignore` — ignore driver output directories, local run logs, Python bytecode, and OS/editor files.
- `COMPUTATIONAL_ENVIRONMENT.md` — document how to record versions and the versions used on the validation server.
- `FILES.md` — provide the categorized file inventory and mark optional/exploratory files discreetly.
- `README.md` — replace the long unstructured inventory with concise setup, driver, reproducibility-scope, and license sections.
- `REVISION_LOG.md` — record this revision, validation, and changed-file summary.
- `run_examples.py` — add the verbose reproducibility driver and timestamped output handling.
- `Dreier25.m` — clarify header only.
- `DujellaPeral2014.m` — clarify header only.
- `Elkies15.m` — clarify header only.
- `Elkies26.m` — clarify header only.
- `Elkies29gen2.m` — clarify header and remove unfinished helper/loop while preserving `f`, `C`, and `xs`.
- `GlueFullTorsion.m` — clarify helper header without changing the gluing formula.
- `HighRankSimpleJacobianExamples.m` — add header, status messages, redirectable `OUTPUT_FILE`, and a neutral Elkies 2015 label.
- `HighRankSplitJacobianExamples.m` — add header and user-friendly status messages around the two gluing computations.
- `Kihara6.m` — clarify header only.
- `PolySqrt.m` — clarify helper header only.
- `RootNumber.gp` — clarify optional PARI/GP header only.
- `RootNumber.m` — clarify helper header without changing Bisatt's root-number formula.
- `Stahlke16.m` — clarify header only.
- `Stahlke22.m` — clarify optional/exploratory header only.
- `Stoll22.m` — clarify header only.
- `StollStats.m` — fix typos/usability, add robust `m` handling, status messages, and redirectable `OUTPUT_FILE`.
- `search-non-torsion.m` — clarify optional/exploratory header only.
- `stollhecke.gp` — clarify optional PARI/GP header only.
- `utils.m` — clarify helper header and assert rational square checks before constructing points from `xs`.
