#!/usr/bin/env python3
"""Verbose driver for the repository's reproducibility examples."""

from __future__ import annotations

import argparse
import datetime as _datetime
import os
from pathlib import Path
import shutil
import shlex
import subprocess
import sys
from typing import Iterable


REPO_ROOT = Path(__file__).resolve().parent


TASK_INFO = {
    "smoke": {
        "what": "Magma smoke test",
        "paper": "Dependency check only; this does not reproduce a paper computation.",
        "software": "Magma",
        "description": "Load RootNumber.m and print RootNumber(a) for a = 1,...,10.",
        "expected": "Ten values of Bisatt's root-number formula for a = 1,...,10.",
        "interpretation": "Successful output means Magma can load the local RootNumber.m helper and evaluate the formula.",
        "optional": False,
    },
    "split": {
        "what": "Appendix A.2 split-Jacobian examples",
        "paper": "Appendix A.2 / Lemma A.1: examples obtained by gluing elliptic curves with full rational 2-torsion.",
        "software": "Magma",
        "description": "Run HighRankSplitJacobianExamples.m.",
        "expected": "Rank statements, degrees, and binary-size estimates for the glued genus-2 curves.",
        "interpretation": "Successful output supports the Appendix A.2 split-Jacobian examples; the Jacobians are isogenous to products of elliptic curves.",
        "optional": False,
    },
    "simple": {
        "what": "Appendix A.1 high-rank simple examples",
        "paper": "Appendix A.1: high-rank simple genus-2 Jacobian examples from the literature.",
        "software": "Magma",
        "description": "Run HighRankSimpleJacobianExamples.m.",
        "expected": "A short table with rank lower bounds and canonical heights.",
        "interpretation": "Successful output reproduces the Appendix A.1 example table and writes Families-list.log in the output directory.",
        "optional": False,
    },
    "stoll": {
        "what": "Section 3.2.1 Stoll/Bisatt-style optional search",
        "paper": "Section 3.2.1: the family C_a : y^2 = x^5 + a.",
        "software": "Magma",
        "description": "Run StollStats.m for one block parameter m.",
        "expected": "Selected lines of the form 'a r' for candidates in the requested block.",
        "interpretation": "Successful output records Magma's computed Mordell-Weil ranks for selected candidates; this optional task may take a while.",
        "optional": True,
    },
    "rootnumber-gp": {
        "what": "PARI/GP root-number timing comparison",
        "paper": "Optional timing/comparison script; not part of the core reproducibility path.",
        "software": "PARI/GP",
        "description": "Run RootNumber.gp with PARI/GP.",
        "expected": "A timing value from the PARI/GP loop.",
        "interpretation": "Successful output means the optional PARI/GP comparison script ran; it is not needed for the Appendix A examples.",
        "optional": True,
    },
}


CORE_TASKS = ["smoke", "split", "simple"]


def executable_exists(executable: str) -> bool:
    if os.path.sep in executable:
        return Path(executable).exists()
    return shutil.which(executable) is not None


def shell_join(command: Iterable[str]) -> str:
    return shlex.join([str(part) for part in command])


def magma_quote(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"')


def detect_version(executable: str, switches: Iterable[str]) -> str | None:
    if not executable_exists(executable):
        return None
    for switch in switches:
        try:
            result = subprocess.run(
                [executable, switch],
                cwd=REPO_ROOT,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                timeout=15,
                check=False,
            )
        except (OSError, subprocess.SubprocessError):
            continue
        text = result.stdout.strip()
        if text:
            return text.splitlines()[0]
    return None


def print_task_list() -> None:
    print("Available tasks:")
    for task in ["smoke", "split", "simple", "core", "stoll", "rootnumber-gp"]:
        if task == "core":
            print("\ncore")
            print("  Description: Run smoke, split, and simple in this order.")
            print("  Software: Magma")
            print("  Expected output: the combined outputs of smoke, split, and simple.")
            continue
        info = TASK_INFO[task]
        optional = " Optional." if info["optional"] else ""
        print(f"\n{task}")
        print(f"  Description: {info['description']}{optional}")
        print(f"  Paper: {info['paper']}")
        print(f"  Software: {info['software']}")
        print(f"  Expected output: {info['expected']}")


def make_output_dir() -> Path:
    stamp = _datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    output_dir = REPO_ROOT / "outputs" / stamp
    output_dir.mkdir(parents=True, exist_ok=False)
    return output_dir


def write_file(path: Path, contents: str) -> None:
    path.write_text(contents, encoding="utf-8")


def print_metadata(task: str, command: list[str], output_file: Path, quiet: bool) -> None:
    if quiet:
        return
    info = TASK_INFO[task]
    print(f"\n[what] {info['what']}")
    print(f"[paper] {info['paper']}")
    print(f"[software] {info['software']}")
    print(f"[command] {shell_join(command)}")
    print(f"[output] Full stdout/stderr: {output_file.relative_to(REPO_ROOT)}")
    print(f"[interpretation] {info['interpretation']}")


def run_command(task: str, command: list[str], output_file: Path, quiet: bool) -> bool:
    print_metadata(task, command, output_file, quiet)
    with output_file.open("w", encoding="utf-8") as handle:
        handle.write(f"$ {shell_join(command)}\n\n")
        handle.flush()
        try:
            result = subprocess.run(
                command,
                cwd=REPO_ROOT,
                text=True,
                stdout=handle,
                stderr=subprocess.STDOUT,
                check=False,
            )
        except OSError as exc:
            handle.write(f"Failed to start command: {exc}\n")
            if not quiet:
                print(f"[result] {task}: failure ({exc})")
            return False
    ok = result.returncode == 0
    if not quiet:
        status = "success" if ok else f"failure (exit {result.returncode})"
        print(f"[result] {task}: {status}")
    return ok


def missing_magma(task: str, magma: str, output_file: Path, quiet: bool) -> bool:
    message = "Magma was not found. Install Magma or pass --magma /path/to/magma."
    if not quiet:
        info = TASK_INFO[task]
        print(f"\n[what] {info['what']}")
        print(f"[paper] {info['paper']}")
        print(f"[software] Magma")
        print(f"[command] {magma}")
        print(f"[output] {output_file.relative_to(REPO_ROOT)}")
        print(f"[interpretation] {message}")
    output_file.write_text(message + "\n", encoding="utf-8")
    return False


def run_magma_task(task: str, output_dir: Path, args: argparse.Namespace) -> str:
    output_file = output_dir / f"{task}.out"
    if not executable_exists(args.magma):
        missing_magma(task, args.magma, output_file, args.quiet)
        return "failure"

    version = detect_version(args.magma, ["-V"])
    if version and not args.quiet:
        print(f"[version] Magma: {version}")

    if task == "smoke":
        wrapper = output_dir / "run_smoke.m"
        write_file(
            wrapper,
            '\n'.join(
                [
                    'print "Smoke test: loading RootNumber.m.";',
                    'load "RootNumber.m";',
                    'print "RootNumber(a) for a = 1,...,10:";',
                    'for a in [1..10] do',
                    '    print a, RootNumber(a);',
                    'end for;',
                    'quit;',
                    '',
                ]
            ),
        )
        command = [args.magma, str(wrapper.relative_to(REPO_ROOT))]
    elif task == "split":
        command = [args.magma, "HighRankSplitJacobianExamples.m"]
    elif task == "simple":
        wrapper = output_dir / "run_simple.m"
        summary = output_dir / "Families-list.log"
        write_file(
            wrapper,
            '\n'.join(
                [
                    f'OUTPUT_FILE := "{magma_quote(str(summary.relative_to(REPO_ROOT)))}";',
                    'load "HighRankSimpleJacobianExamples.m";',
                    'quit;',
                    '',
                ]
            ),
        )
        command = [args.magma, str(wrapper.relative_to(REPO_ROOT))]
    elif task == "stoll":
        wrapper = output_dir / "run_stoll.m"
        stoll_log = output_dir / f"stoll-{args.m}.log"
        write_file(
            wrapper,
            '\n'.join(
                [
                    f"m := {args.m};",
                    f'OUTPUT_FILE := "{magma_quote(str(stoll_log.relative_to(REPO_ROOT)))}";',
                    'load "StollStats.m";',
                    'quit;',
                    '',
                ]
            ),
        )
        command = [args.magma, str(wrapper.relative_to(REPO_ROOT))]
    else:
        raise ValueError(f"Unknown Magma task {task}")

    return "success" if run_command(task, command, output_file, args.quiet) else "failure"


def run_gp_task(output_dir: Path, args: argparse.Namespace) -> str:
    task = "rootnumber-gp"
    output_file = output_dir / f"{task}.out"
    if not executable_exists(args.gp):
        message = "PARI/GP was not found. Install PARI/GP or pass --gp /path/to/gp to run this optional task."
        if not args.quiet:
            info = TASK_INFO[task]
            print(f"\n[what] {info['what']}")
            print(f"[paper] {info['paper']}")
            print("[software] PARI/GP")
            print(f"[command] {args.gp} -q RootNumber.gp")
            print(f"[output] {output_file.relative_to(REPO_ROOT)}")
            print(f"[interpretation] {message}")
        output_file.write_text(message + "\n", encoding="utf-8")
        return "skipped"

    version = detect_version(args.gp, ["--version", "-v"])
    if version and not args.quiet:
        print(f"[version] PARI/GP: {version}")
    command = [args.gp, "-q", "RootNumber.gp"]
    return "success" if run_command(task, command, output_file, args.quiet) else "failure"


def summarize(statuses: list[tuple[str, str]], output_dir: Path) -> None:
    print("\nCompleted tasks:")
    for task, status in statuses:
        print(f"- {task}: {status}")
    print(f"Output directory: {output_dir.relative_to(REPO_ROOT)}")


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Run reproducibility examples for the paper supplement.")
    parser.add_argument("--list", action="store_true", help="List available tasks and exit unless --task is also supplied.")
    parser.add_argument("--task", choices=["smoke", "split", "simple", "core", "stoll", "rootnumber-gp"], help="Task to run.")
    parser.add_argument("--m", type=int, default=1, help="Block parameter for --task stoll.")
    parser.add_argument("--magma", default="magma", help="Path to the Magma executable.")
    parser.add_argument("--gp", default="gp", help="Path to the PARI/GP executable.")
    parser.add_argument("--quiet", action="store_true", help="Only print the final summary.")
    args = parser.parse_args(argv)
    if not args.list and args.task is None:
        parser.error("pass --list or --task")
    return args


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    if args.list:
        print_task_list()
        if args.task is None:
            return 0

    requested = CORE_TASKS if args.task == "core" else [args.task]
    output_dir = make_output_dir()
    statuses: list[tuple[str, str]] = []
    for task in requested:
        if task == "rootnumber-gp":
            status = run_gp_task(output_dir, args)
        else:
            status = run_magma_task(task, output_dir, args)
        statuses.append((task, status))

    summarize(statuses, output_dir)
    failed_required = any(status == "failure" and not TASK_INFO[task]["optional"] for task, status in statuses)
    failed_optional = any(status == "failure" and TASK_INFO[task]["optional"] for task, status in statuses)
    return 1 if failed_required or failed_optional else 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
