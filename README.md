# Logarithmic Density of Positive-Rank Genus-2 Jacobians

Online supplement to:

**Logarithmic Density of Rank ≥ 1 and Rank ≥ 2 Genus-2 Jacobians and Applications to Hyperelliptic Curve Cryptography**
R. Barbulescu, M. Barcau, V. Pașol, and G. Turcaș.

## What this repository contains

This repository contains Magma, PARI/GP, and data files used to reproduce and inspect the computational examples accompanying the paper. The scripts illustrate the examples and computations discussed in Section 3 and Appendix A; they are not used as proofs of the density theorems.

## Requirements

Core examples:
- Magma, version V2.29-7 in the latest validation environment.

Optional examples:
- PARI/GP, version 2.17.2 in the latest validation environment, for `.gp` timing/comparison files.

## Quick start with Magma

```bash
git clone https://github.com/BarbulescuR/Logarithmic-density-of-positive-rank-genus-2-Jacobians.git
cd Logarithmic-density-of-positive-rank-genus-2-Jacobians
git checkout temporary

python3 run_examples.py --list
python3 run_examples.py --task smoke
python3 run_examples.py --task core
```

## What the driver script does

`run_examples.py` is the preferred entry point. It prints what each task does, which paper section or appendix it supports, the exact command it runs, and where the full output is stored. The script is verbose by default and stores outputs in `outputs/<timestamp>/`.

- `smoke` — loads `RootNumber.m` in Magma and prints `RootNumber(a)` for `a = 1,...,10`; this only checks that Magma can load the local code.
- `split` — runs `HighRankSplitJacobianExamples.m` for the Appendix A.2 / Lemma A.1 gluing examples.
- `simple` — runs `HighRankSimpleJacobianExamples.m` for the Appendix A.1 high-rank simple genus-2 Jacobian examples.
- `core` — runs `smoke`, `split`, and `simple` in that order.
- `stoll` — optionally runs `StollStats.m` for one block parameter `m` in the Section 3.2.1 family `C_a : y^2 = x^5 + a`.
- `rootnumber-gp` — optionally runs `RootNumber.gp`, a PARI/GP timing/comparison script.

## Running individual Magma files directly

```bash
magma HighRankSplitJacobianExamples.m
magma HighRankSimpleJacobianExamples.m
magma "m:=3" StollStats.m
```

The Python driver is preferred because it logs commands and output and avoids overwriting generated logs in the repository root.

## Reproducibility scope

- `HighRankSimpleJacobianExamples.m` supports Appendix A.1.
- `HighRankSplitJacobianExamples.m` supports Appendix A.2 / Lemma A.1.
- `StollStats.m` supports the optional Section 3.2.1 computations for `C_a : y^2 = x^5 + a`.
- `stollhecke.gp` is optional and illustrates a Hecke-character approach; it is not part of the default reproduction path.

The latest validation experiments were run on `lehner`, a University of Warwick machine. We thank John Cremona for providing one of the authors access to this server.

## File inventory

See [`FILES.md`](FILES.md).

## License

GPL-3.0.
