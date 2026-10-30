#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
mkdir -p 06_GDSII/physical
python3 - <<'END'
import os,shutil,importlib.util,json
from pathlib import Path
r={'tools':{t:shutil.which(t) for t in ['openroad','magic','netgen','klayout']},'librelane_installed':bool(importlib.util.find_spec('librelane')),'PDK_ROOT':os.environ.get('PDK_ROOT'),'status':'NOT_RUN'}
p=Path('06_GDSII/physical');(p/'environment.json').write_text(json.dumps(r,indent=2))
print(json.dumps(r,indent=2))
END
# Always attempt the flow and preserve its real exit status/log.
# PDK and the compatible LibreLane tool environment must be provisioned externally.
set +e
python3 -m librelane 04_IMPLEMENTATION/scripts/config_librelane.json 2>&1 | tee 06_GDSII/physical/flow.log
status=${PIPESTATUS[0]}
set -e
printf '%s\n' "$status" > 06_GDSII/physical/exit_code.txt
exit "$status"
