all: create flow open

clean:
	rm -rf ./vivado_project || true
	rm -rf ./rpt || true	
	rm -f *log 
	rm -f *jou

flow: logic_synth phy_synth program

open: 
	vivado -mode tcl -source ../../scripts/open_project_gui.tcl

create:
	vivado -mode tcl -source create_project.tcl

logic_synth:
	vivado -mode tcl -source ../../scripts/logic_synthesis.tcl

phy_synth:
	vivado -mode tcl -source ../../scripts/physical_synthesis.tcl

update:
	vivado -mode tcl -source update_project.tcl

behavioral_sim:
	vivado -mode tcl -source ../../scripts/behavioral_sim.tcl

post_synth_sim:
	vivado -mode tcl -source ../../scripts/post_synthesis_timing_sim.tcl

post_imp_sim:
	vivado -mode tcl -source ../../scripts/post_implementation_timing_sim.tcl

program:
	vivado -mode tcl -source ../../scripts/program.tcl


