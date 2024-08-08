#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Script para programar FPGA
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     program.tcl
#-- Descripcion: Programa la tarjeta FPGA
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           31-03-2023   PMP        Original
#----------------------------------------------------------------------------------------------------


# Typical usage: vivado -mode tcl -source program.tcl
# Create the project and directory structure
source ./globals.tcl

after 1

file delete {*}[glob *backup.jou]
file delete {*}[glob *backup.log]

open_project ./$VIVADO_FOLDER/$VIVADO_FOLDER.xpr

# Change to hardware manager
open_hw
connect_hw_server
open_hw_target

# Define the Bitfile
set BITFILE ${PROJECT_PATH}/${VIVADO_FOLDER}/${VIVADO_FOLDER}.runs/impl_1/${DESIGN_TOP}.bit

# Programming process
set_property PROGRAM.FILE  ${BITFILE}  [get_hw_devices ${HW_DEV}]
current_hw_device [get_hw_devices ${HW_DEV}]
program_hw_devices [ current_hw_device ]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices ${HW_DEV}] 0]

close_hw_target
exit;