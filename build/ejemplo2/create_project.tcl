#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Script de creacion de proyecto
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     create_project.tcl
#-- Descripcion: Genera un proyecto de vivado e incluye los archivos presentes en la carpetas de fuentes
#--              Genera la estructura de carpetas de fuentes de no existir
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           27-03-2023   PMP        Original
#----------------------------------------------------------------------------------------------------

# Typical usage: vivado -mode tcl -source create_project.tcl

#load GLOBALS
source ./globals.tcl

# Create the project and directory structure
file mkdir $ROOT_PATH/src/ejemplo2 ;
file mkdir $ROOT_PATH/src/ejemplo2/design ;
file mkdir $ROOT_PATH/src/ejemplo2/testbench ;
file mkdir $ROOT_PATH/src/ejemplo2/constraints ;
file mkdir $ROOT_PATH/src/ejemplo2/ips ;
file mkdir $PROJECT_PATH/$REPORTS_FOLDR ;
file mkdir $PROJECT_PATH/$VIVADO_FOLDER ;
create_project -force $VIVADO_FOLDER ./$VIVADO_FOLDER -part $FPGA_MODEL

# Miscellaneous folders
if {[info exists GTKWAVE]} {
    file mkdir $PROJECT_PATH/$GTKWAVE ;
}


# Add various sources to the project
# If you need to check for subfolders remove the option -norecurse

# Design files
add_files -norecurse -fileset sources_1 $ROOT_PATH/src/ejemplo2/design
# IP files - Need to be added one by one
# add_files -norecurse -fileset sources_1 $ROOT_PATH/src/ips/clk_wiz_0/clk_wiz_0.xci
# Testbench files
add_files -norecurse -fileset sim_1 $ROOT_PATH/src/ejemplo2/testbench
# Constraint files
add_files -norecurse -fileset constrs_1 $ROOT_PATH/src/ejemplo2/constraints/

#
# Can open the graphical environment if visualization desired
# comment out the for batch mode
#start_gui
# If the GUI is enabled, then comment out the next line
exit
