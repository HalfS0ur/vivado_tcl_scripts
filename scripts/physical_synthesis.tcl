#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Script de sintesis fisica
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     physical_synthesis.tcl
#-- Descripcion: Ejecuta la sintesis fisica y generacion del bitstream del diseno
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           27-03-2023   PMP        Original
#----------------------------------------------------------------------------------------------------

# Typical usage: vivado -mode tcl -source physical_synthesis.tcl
# Create the project and directory structure
source ./globals.tcl

after 1

file delete {*}[glob *backup.jou]
file delete {*}[glob *backup.log]

# if needed, re-define TOP design unit
#set DESIGN_TOP "counter"

open_project ./$VIVADO_FOLDER/$VIVADO_FOLDER.xpr

set_property top $DESIGN_TOP [get_filesets sources_1]

# Launch Implementation
if {[catch {reset_run impl_1}]} {
    puts stderr "(ignore) No active runs to reset"
}
launch_runs -jobs $JOBS impl_1 -to_step write_bitstream
wait_on_run impl_1
#
# Generate a timing and power reports and write to disk
# comment out the open_run for batch mode
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained \
-check_timing_verbose -max_paths 10 -input_pins -file  $PROJECT_PATH/$REPORTS_FOLDR/imp_timing.rpt
report_power -file  $PROJECT_PATH/$REPORTS_FOLDR/imp_power.rpt

# Open GUI for programming FPGA board or if visualization desired
#start_gui -verbose
# If the GUI is enabled, then comment out the next line
exit