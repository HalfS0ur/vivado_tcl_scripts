#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Variables globales para el flujo de trabajo
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     globals.tcl
#-- Descripcion: Carga variables globales a los scripts
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           27-03-2023   PMP        Original
#-- 1           31-03-2023   PMP        Compatibilidad con GTKWave
#-- 2           31-03-2023   PMP        Compatibilidad con programacion desde TCL
#----------------------------------------------------------------------------------------------------

#global variables 

# Change to your design and simulation files
# These can also be overwritten on a specific simulation or synthesis script
set DESIGN_TOP "counter"
set SIMULATION_TOP "counter_tb"

# Enable to use RECURSIVE search in forlders
#set RECURSIVE_SEARCH "recursive"

# Choose waveform viewer (default vivado-gui)
set GTKWAVE "gtkwave_vcd"

# This is the project path
set PROJECT_PATH [pwd]
set ROOT_PATH $PROJECT_PATH/../..

# Folder for the vivado project folder
set VIVADO_FOLDER "vivado_project"

# Folder for synthesis reports
set REPORTS_FOLDR "rpt"

#FPGA model, choose accordingly
#nexys 4
#set FPGA_MODEL "XC7A100TCSG324-1"
#set HW_DEV "xc7a100t_0"
#basys 3
set FPGA_MODEL "XC7A35TCPG236-1"
set HW_DEV "xc7a35t_0"
#nexys 7a
#set FPGA_MODEL "XC7A100TCSG324-1"
#set HW_DEV "xc7a100t_0"

#Modify according to your PC capacity
set JOBS "4"
