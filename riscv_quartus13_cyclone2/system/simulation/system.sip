set_global_assignment -entity "system" -library "lib_system" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "system" -library "lib_system" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "system" -library "lib_system" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_system" -name SPD_FILE [file join $::quartus(sip_path) "../../system.spd"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "../../system.qsys"]

set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "system.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_translator.sv"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_master_translator.sv"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_jtag_uart_0.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_add_sub.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_compare.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_convert.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_convert_float_integer.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_div.hex"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_div.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_mult.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_sqrt.qip"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/dmem.hex"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/imem.hex"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/riscv.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/alu.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/aluSource.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/controlUnit.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/DRAM.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/forwadingUnit.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/FPU.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Fpu_Controller.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/hdu.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/immGen.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/IRAM.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mux.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/regFile.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_add_sub.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_compare.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_convert.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_convert_float_integer.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_div.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_mult.v"]
set_global_assignment -library "lib_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/fpu_sqrt.v"]
