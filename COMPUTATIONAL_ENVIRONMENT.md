# Computational environment

The core scripts require Magma. Optional timing/comparison scripts use PARI/GP.

The latest validation experiments were run on `lehner`, a University of Warwick machine.

## How to record local versions

```bash
magma -v
gp -v
python3 --version
```

## Versions used in the latest repository polish

- Python: Python 3.14.2
- Magma: V2.29-7, detected on the `lehner` validation server
- PARI/GP: GP/PARI CALCULATOR Version 2.17.2, detected on the `lehner` validation server

## Notes

The ANTS software reviewer reported testing the original submission with Magma 2.28.11 and PARI/GP 2.15.1.
