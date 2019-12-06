transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_add_sub.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_mult.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_div.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_compare.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_sqrt.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_convert.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject {C:/Users/naqas/Desktop/riscvProject/fpu_convert_float_integer.v}
vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/Github/RISC-V/riscv_core {C:/Users/naqas/Desktop/Github/RISC-V/riscv_core/riscv.v}

vlog -vlog01compat -work work +incdir+C:/Users/naqas/Desktop/riscvProject/../Github/RISC-V/riscv_core {C:/Users/naqas/Desktop/riscvProject/../Github/RISC-V/riscv_core/riscv.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all