.PHONY: all sim synth physical
all:
	bash 04_IMPLEMENTATION/scripts/run_all.sh
sim:
	bash 04_IMPLEMENTATION/scripts/01_run_sim.sh
synth:
	bash 04_IMPLEMENTATION/scripts/02_run_synth.sh
physical:
	bash 04_IMPLEMENTATION/scripts/04_run_physical.sh
