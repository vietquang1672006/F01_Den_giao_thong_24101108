#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
mkdir -p 06_GDSII/synthesis
command -v yosys >/dev/null || { echo 'ERROR: install yosys'; exit 2; }
yosys -Q -T -l 06_GDSII/synthesis/yosys.log -p '
 read_verilog -sv 04_IMPLEMENTATION/rtl/f01_traffic_fsm_explicit.sv
 synth -top f01_traffic_fsm_explicit
 tee -o 06_GDSII/synthesis/synth_stat.txt stat
 tee -o 06_GDSII/synthesis/stat.json stat -json
 write_json 06_GDSII/synthesis/netlist.json
 write_verilog -noattr 06_GDSII/synthesis/netlist.v
' > 06_GDSII/synthesis/console.log 2>&1
cat 06_GDSII/synthesis/synth_stat.txt
python3 - <<'END'
import json
from pathlib import Path
p=Path('06_GDSII/synthesis');m=json.loads((p/'netlist.json').read_text())['modules']['f01_traffic_fsm_explicit']
cells=m['cells']; ffs=[(k,v) for k,v in cells.items() if 'DFF' in v['type']]
qbits={b for k,c in ffs for b in c['connections']['Q']}
state=m['netnames']['state']['bits']
assert len(ffs)==6,(len(ffs),ffs)
assert set(state)<=qbits
assert not any('LATCH' in c['type'] for c in cells.values())
s={'mapping':'Yosys generic cells, no PDK mapping','cells':len(cells),'flip_flops':len(ffs),'state_bits':len(state),'state_q_bits':state,'ff_cells':[{'name':k,'type':c['type'],'Q':c['connections']['Q']} for k,c in ffs]}
(p/'summary.json').write_text(json.dumps(s,indent=2));print(json.dumps(s,indent=2))
END
