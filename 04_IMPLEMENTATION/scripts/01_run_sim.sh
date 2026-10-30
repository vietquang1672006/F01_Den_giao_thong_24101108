#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
command -v iverilog >/dev/null || { echo 'ERROR: install iverilog'; exit 2; }
mkdir -p 05_VERIFICATION/{vectors,waveforms,logs,traces} build
python3 05_VERIFICATION/golden_model/check_model.py | tee 05_VERIFICATION/logs/model.log
for config in '1 1' '2 2' '3 3' '4 2' '5 3' '8 4'; do
 read -r p n <<< "$config"
 name="p${p}_n${n}"
 iverilog -g2012 -s f01_tb -P "f01_tb.P=$p" -P "f01_tb.N=$n" -o "build/$name.vvp" \
  04_IMPLEMENTATION/rtl/*.sv 05_VERIFICATION/testbench/f01_tb.sv \
  > "05_VERIFICATION/logs/${name}_compile.log" 2>&1
 vvp "build/$name.vvp" "+VECTORS=05_VERIFICATION/vectors/$name.txt" \
  "+VCD=05_VERIFICATION/waveforms/$name.vcd" "+TRACE=05_VERIFICATION/traces/$name.csv" \
  | tee "05_VERIFICATION/logs/$name.log"
 grep -q "RTL PASS" "05_VERIFICATION/logs/$name.log"
done
