transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/FPGA/riscV {C:/Users/naqas/Desktop/FPGA/riscV/riscv.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/FPGA/riscV {C:/Users/naqas/Desktop/FPGA/riscV/regFile.v}

