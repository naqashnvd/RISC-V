
# (C) 2001-2020 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.0sp1 232 win32 2020.02.13.02:43:44

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="system"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/13.0sp1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/jtag_uart_0_avalon_jtag_slave_translator/
mkdir -p ./libraries/riscv_core_0_avalon_master_translator/
mkdir -p ./libraries/jtag_uart_0/
mkdir -p ./libraries/riscv_core_0/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cycloneii_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/fpu_div.hex ./
  cp -f $QSYS_SIMDIR/submodules/dmem.hex ./
  cp -f $QSYS_SIMDIR/submodules/imem.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v" -work altera_ver      
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"          -work lpm_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"             -work sgate_ver       
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"         -work altera_mf_ver   
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"     -work altera_lnsim_ver
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.v"   -work cycloneii_ver   
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_controller.v"          -work rst_controller                          
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"        -work rst_controller                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"  -work jtag_uart_0_avalon_jtag_slave_translator
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv" -work riscv_core_0_avalon_master_translator   
  vlogan +v2k           "$QSYS_SIMDIR/submodules/system_jtag_uart_0.v"               -work jtag_uart_0                             
  vlogan +v2k           "$QSYS_SIMDIR/submodules/riscv.v"                            -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alu.v"                              -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/aluSource.v"                        -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/controlUnit.v"                      -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/DRAM.v"                             -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/forwadingUnit.v"                    -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/FPU.v"                              -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/Fpu_Controller.v"                   -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/hdu.v"                              -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/immGen.v"                           -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/IRAM.v"                             -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/mux.v"                              -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/regFile.v"                          -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_add_sub.v"                      -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_compare.v"                      -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_convert.v"                      -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_convert_float_integer.v"        -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_div.v"                          -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_mult.v"                         -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/fpu_sqrt.v"                         -work riscv_core_0                            
  vlogan +v2k           "$QSYS_SIMDIR/system.v"                                                                                    
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $USER_DEFINED_SIM_OPTIONS
fi
