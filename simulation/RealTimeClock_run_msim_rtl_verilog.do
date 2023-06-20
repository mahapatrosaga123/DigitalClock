transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/LT24Display.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/DigitalClock.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/AlarmSet.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/AlarmEnable.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/DisplaySegment.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/RealTimeClock.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/hourlychime.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23 {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/LT24Top.v}

vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/simulation {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/simulation/LT24FunctionalModel.v}
vlog -vlog01compat -work work +incdir+C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/simulation {C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/simulation/LT24Top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  LT24Top_tb

do C:/Users/mahap/workspace/ELEC5566M-Mini-Project-Group-23/../ELEC5566M-Resources/simulation/load_sim.tcl
