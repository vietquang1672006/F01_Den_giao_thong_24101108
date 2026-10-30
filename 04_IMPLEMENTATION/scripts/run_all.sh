#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
mkdir -p 07_TRACEABILITY
{
 date -u +'%Y-%m-%dT%H:%M:%SZ'
 cat /etc/os-release
 uname -m
 python3 --version
 iverilog -V 2>/dev/null | sed -n '1p'
 yosys -V
 git rev-parse HEAD 2>/dev/null || true
} > 07_TRACEABILITY/environment.txt
bash 04_IMPLEMENTATION/scripts/01_run_sim.sh
bash 04_IMPLEMENTATION/scripts/02_run_synth.sh
bash 04_IMPLEMENTATION/scripts/03_check_safety.sh
set +e
bash 04_IMPLEMENTATION/scripts/04_run_physical.sh > 06_GDSII/physical_attempt.log 2>&1
physical_status=$?
set -e
cat 06_GDSII/physical_attempt.log
if (( physical_status != 0 )); then
 echo "Physical flow failed (exit $physical_status): inspect 06_GDSII/physical/flow.log"
fi
# RTL and synthesis fail the script if broken; physical failure is retained explicitly.
