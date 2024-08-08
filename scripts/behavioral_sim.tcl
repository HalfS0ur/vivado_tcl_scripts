#----------------------------------------------------------------------------------------------------
#   Herramientas de flujo de diseño con vivado (2019.1)
#----------------------------------------------------------------------------------------------------
#--
#-- Componente:  Script de simulacion de comportamiento
#-- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
#-- Archivo:     behavioral_sim.tcl
#-- Descripcion: Ejecuta una simulacion de comportamiento sobre el diseno actual
#--
#----------------------------------------------------------------------------------------------------
#-- Revision    Fecha        Revisor    Comentarios
#-- 0           27-03-2023   PMP        Original
#-- 1           31-03-2023   PMP        Compatibilidad con GTKWave
#----------------------------------------------------------------------------------------------------

# Typical usage: vivado -mode tcl -source behavioral_sim.tcl
source ./globals.tcl

after 1

file delete {*}[glob *backup.jou]
file delete {*}[glob *backup.log]

# if needed, re-define TOP simulation unit
#set SIMULATION_TOP "counter_tb"


open_project ./$VIVADO_FOLDER/$VIVADO_FOLDER.xpr

set_property top $SIMULATION_TOP [get_filesets sim_1]

set_property -name xelab.more_options -value {-debug all} -objects [get_filesets sim_1]
set_property runtime {0} [get_filesets sim_1]
launch_simulation -simset sim_1 -mode behavioral


# Define Visualization (by default vivado-gui)
# Check globals for options

if {[info exists GTKWAVE]} {
    file mkdir ${PROJECT_PATH}/${GTKWAVE} ;
    # Option GTKWAVE
    set VCD_FILE ${PROJECT_PATH}/${GTKWAVE}/${SIMULATION_TOP}_beh_sim.vcd
    open_vcd ${VCD_FILE}
    
    # Single singals can be captured
    #log_vcd {/dut/clk_i}
    #log_vcd {/dut/rst_i}

    # All signals from a specific module can be captured
    #log_vcd {/dut/inst_0/*}

    # Or, all signals in the design can be captured (large size file)
    log_vcd [get_objects -r * ]

    # run the simulation for a given time or until it finishes (using -all)
    # Available time units: ps, ns, us, ms, s 
    #run 1 us
    run -all

    close_vcd

    # Invoke GTKWave
    if { [catch { exec gtkwave -f ${VCD_FILE} } msg] } {
        puts "GTKWAVE $::errorInfo"
    };

    exit ;

} else {
    # Default option Vivado GUI

    # The signals in the Testbench module are added by default
    
    # Additional Signals can be added

    # you can add as many waves as needed, make reference to modules hierarchically
    # e.g.: /$SIMULATION_TOP/dut/mod1/mod2/signal_a  --> imports signal_a into the diagram (signal_a is part of instance mod2 which is part of instance mod1 inside instance dut)
    # e.g.: /$SIMULATION_TOP/dut/mod1/* --> import all signals from instance mod1

    #add_wave /$SIMULATION_TOP/dut/*

    #wave dividers can be added.
    #add_wave_divider <name>

    # run the simulation for a given time or until it finishes (using -all)
    # Available time units: ps, ns, us, ms, s 
    #run 1 us
    run -all


    # Open the graphical environment for visualization
    # Remove if not needed (e.g. autoverificacion)
    start_gui -verbose

    # If no GUI is not needed (start_gui is commented out), then enable exit
    # e.g. in autoverification
    #exit
}