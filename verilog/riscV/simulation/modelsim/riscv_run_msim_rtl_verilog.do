transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/riscv.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/regFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/controlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/immGen.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV {C:/Users/naqas/Desktop/Github/RISC-V/verilog/riscV/alu.v}

