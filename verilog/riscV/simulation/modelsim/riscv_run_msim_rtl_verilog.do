transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/alu.v}

