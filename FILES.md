# File inventory

## Main entry point

- `run_examples.py` — verbose driver for the reproducibility examples written with the assistance of GPT 5.5 (OpenAI CodeX).

## Core Magma scripts

- `HighRankSimpleJacobianExamples.m` — Appendix A.1 high-rank simple genus-2 examples from the literature.
- `HighRankSplitJacobianExamples.m` — Appendix A.2 / Lemma A.1 split-Jacobian gluing examples.
- `StollStats.m` — optional Section 3.2.1 search/statistics for `C_a : y^2 = x^5 + a`.

## Magma helper files

- `utils.m` — helper routines for rank/height summaries and coefficient-size estimates.
- `GlueFullTorsion.m` — helper implementing the full-rational-2-torsion gluing construction.
- `RootNumber.m` — Magma implementation of Bisatt's root-number formula for `Jac(y^2 = x^p + a)`.
- `PolySqrt.m` — helper that computes the polynomial part of a square root expansion.

## Curve/example data files

- `Stahlke16.m` — Stahlke genus-2 curve used in the Appendix A.1 simple-Jacobian examples.
- `Stoll22.m` — Mueller-Stoll genus-2 curve used in the Appendix A.1 simple-Jacobian examples.
- `Dreier25.m` — Dreier genus-2 curve used in the Appendix A.1 simple-Jacobian examples.
- `Elkies26.m` — Elkies genus-2 curve used in the Appendix A.1 simple-Jacobian examples.
- `Elkies29gen2.m` — Elkies 2015 genus-2 curve data used in the Appendix A.1 simple-Jacobian examples.
- `Elkies15.m` — Elkies rank-15 elliptic curve with full rational 2-torsion used for gluing.
- `DujellaPeral2014.m` — Dujella-Peral elliptic-curve family used for a split-Jacobian gluing example.
- `Kihara6.m` — Kihara elliptic-curve family used for a split-Jacobian gluing example.

## Optional / exploratory files

- `Stahlke22.m` — exploratory/attempt file; not used by the main scripts.
- `search-non-torsion.m` — optional search related to Remark 2.2.
- `stollhecke.gp` — optional Hecke-character L-function computation, not used by the default workflow.
- `RootNumber.gp` — optional PARI/GP timing/comparison script.
- `genus1rank2.dat`, `genus2rank2.dat` — optional numerical data for density comparisons.
- `stoll.log` — saved output from previous Stoll-style computations.
- `Families-list.log` — saved/sample output from previous simple-Jacobian computations.

## Generated outputs

`run_examples.py` writes timestamped output directories under `outputs/`. These generated directories are ignored by Git and therefore not present here.
