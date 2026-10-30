#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
mkdir -p 05_VERIFICATION/logs
yosys -Q -T -l 05_VERIFICATION/logs/safety_sat.log -p '
 read_verilog -sv 04_IMPLEMENTATION/rtl/f01_traffic_fsm_explicit.sv
 read_verilog -sv 05_VERIFICATION/assert_safety.sv
 prep -top f01_safety
 flatten
 sat -seq 1 -set-init-def -set-def-inputs -prove safe 1 -verify
' > 05_VERIFICATION/logs/safety_console.log 2>&1
grep 'SUCCESS' 05_VERIFICATION/logs/safety_sat.log
