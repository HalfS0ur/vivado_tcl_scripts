#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Script de sintesis logica
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     logic_synthesis.tcl
#-- Descripcion: Ejecuta la sintesis logica del diseno
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           27-03-2023   PMP        Original
#----------------------------------------------------------------------------------------------------

# Typical usage: vivado -mode tcl -source logic_synthesis.tcl
# Create the project and directory structure
source ./globals.tcl

after 1

file delete {*}[glob -nocomplain *backup.jou]
file delete {*}[glob -nocomplain *backup.log]

# if needed, re-define TOP design unit
#set DESIGN_TOP "counter"

open_project ./$VIVADO_FOLDER/$VIVADO_FOLDER.xpr -part $FPGA_MODEL

set_property top $DESIGN_TOP [get_filesets sources_1]

# Launch Synthesis
if {[catch {reset_run synth_1}]} {
    puts stderr "(ignore) No active runs to reset"
}
launch_runs -jobs $JOBS synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1
#
# Generate a timing and power reports and write to disk
# Can create custom reports as required
report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose \
-max_paths 10 -input_pins -file $PROJECT_PATH/$REPORTS_FOLDR/syn_timing.rpt
report_power -file $PROJECT_PATH/$REPORTS_FOLDR/syn_power.rpt

# Can open the graphical environment if visualization desired 
# start_gui
# If the GUI is enabled, then comment out the next line
exit