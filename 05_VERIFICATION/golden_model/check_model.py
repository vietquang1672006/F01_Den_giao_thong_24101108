#!/usr/bin/env python3
"""Independent state model and deterministic vectors; standard library only."""
import json, random
from pathlib import Path
from collections import deque
from itertools import product
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'05_VERIFICATION/vectors'
CONFIGS=[(1,1),(2,2),(3,3),(4,2),(5,3),(8,4)]
def output(q,m):
 s,pc,nc,h=q
 lamps=([0x21,0x22,0x0c,0x14][s] if not m else (0x12 if h else 0))
 return (s<<6)|lamps
def step(q,r,e,m,P=4,N=2):
 s,pc,nc,h=q
 if not r:return (0,0,0,0)
 if not e:return q
 if m:return (s,0,(nc+1)%N,h^int(nc+1==N))
 return ((s+int(pc+1==P))%4,(pc+1)%P,0,0)
def reachable(P,N):
 paths={(0,0,0,0):[]}; todo=deque(paths)
 while todo:
  q=todo.popleft()
  for controls in product(range(2),repeat=3):
   t=step(q,*controls,P,N)
   if t not in paths:paths[t]=paths[q]+[controls];todo.append(t)
 return paths
def main():
 OUT.mkdir(exist_ok=True); summary=[]
 for P,N in CONFIGS:
  q=(0,0,0,0); rows=[]; groups=[]
  def add(label,controls):
   nonlocal q
   start=len(rows)
   for r,e,m in controls:
    pre=output(q,m);q=step(q,r,e,m,P,N);post=output(q,m)
    assert not ((pre&1) and (pre&8))
    assert not ((post&1) and (post&8))
    rows.append((r,e,m,pre,post,*q))
   groups.append({'case':label,'start_vector':start,'vectors':len(rows)-start})
  add('reset_overrides_disable',[(0,0,1),(0,1,0),(1,1,0)])
  add('two_full_cycles',[(0,1,0)]+[(1,1,0)]*(8*P))
  add('night_entry_and_return',[(0,1,0)]+[(1,1,0)]*(P+max(1,P//2))+[(1,1,1)]*(4*N)+[(1,1,0)]*(2*P))
  add('ena_freeze_day_night_overlay',[(1,0,0)]*3+[(1,0,1)]*3+[(1,1,1)]*N+[(1,0,1)]*3+[(1,0,0)]*3+[(1,1,0)]*(2*P))
  add('reset_during_night',[(1,1,1)]*N+[(0,0,1),(1,1,1),(1,1,0)])
  rng=random.Random(20261028+P*100+N)
  add('seeded_random',[(int(rng.random()>.04),rng.randrange(2),rng.randrange(2)) for _ in range(600)])
  paths=reachable(P,N)
  # For default parameters cover every reachable state and every binary input edge on RTL.
  if (P,N)==(4,2):
   controls=[]
   for state,path in paths.items():
    for edge in product(range(2),repeat=3):controls += [(0,1,0)]+path+[edge]
   add('all_224_reachable_edges',controls)
  f=OUT/f'p{P}_n{N}.txt';f.write_text(''.join(' '.join(map(str,row))+'\n' for row in rows))
  summary.append({'P':P,'N':N,'vectors':len(rows),'reachable_states':len(paths),'reachable_edges':len(paths)*8,'cases':groups})
 # Exhaust all 16 stable decoder combinations.
 for s,m,h in product(range(4),range(2),range(2)):
  v=output((s,0,0,h),m);assert not ((v&1) and (v&8))
 (OUT/'summary.json').write_text(json.dumps(summary,indent=2))
 print('MODEL PASS: 16 decoder combinations; default 28 states / 224 edges')
 print('Generated',sum(x['vectors'] for x in summary),'vectors for',len(CONFIGS),'parameter configurations')
if __name__=='__main__':main()
