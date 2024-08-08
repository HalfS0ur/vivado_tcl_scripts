#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Script de actualizacion de proyecto
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     update_project.tcl
#-- Descripcion: Actualiza el proyecto con nuevos archivos
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           27-03-2023   PMP        Original
#----------------------------------------------------------------------------------------------------

# Typical usage: vivado -mode tcl -source update_project.tcl
# Create the project and directory structure
source ./globals.tcl

after 1

file delete {*}[glob *backup.jou]
file delete {*}[glob *backup.log]

open_project ./$VIVADO_FOLDER/$VIVADO_FOLDER.xpr
#
# Add various sources to the project
# If you need to check for subfolders remove the option -norecurse

# The -quiet option has been used to remove warnings about files existing
# remove this flag if suspecting a problem when adding the files to the project
# Design files
add_files -norecurse -fileset sources_1 $ROOT_PATH/src/ejemplo1/design
# IP files - Need to be added one by one
#add_files -norecurse -fileset sources_1 $ROOT_PATH/src/ejemplo1/ips/clk_wiz_0/clk_wiz_0.xci
# Testbench files
add_files -norecurse -quiet -fileset sim_1 $ROOT_PATH/src/ejemplo1/testbench
# Constraint files
add_files -norecurse -quiet -fileset constrs_1 $ROOT_PATH/src/ejemplo1/constraints/


# Can open the graphical environment if visualization desired 
# start_gui
# If the GUI is enabled, then comment out the next line
exit
