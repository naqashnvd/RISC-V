
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

# ACDS 13.0sp1 232 win32 2020.02.03.23:37:45

# ----------------------------------------
# vcs - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="system"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/13.0sp1/quartus/"
SKIP_FILE_COPY=0
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
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/fpu_div.hex ./
  cp -f $QSYS_SIMDIR/submodules/dmem.hex ./
  cp -f $QSYS_SIMDIR/submodules/imem.hex ./
fi

vcs -lca -timescale=1ps/1ps -sverilog +verilog2001ext+.v -ntb_opts dtm $USER_DEFINED_ELAB_OPTIONS \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v \
  $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.v \
  $QSYS_SIMDIR/submodules/altera_reset_controller.v \
  $QSYS_SIMDIR/submodules/altera_reset_synchronizer.v \
  $QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv \
  $QSYS_SIMDIR/submodules/system_jtag_uart_0.v \
  $QSYS_SIMDIR/submodules/riscv.v \
  $QSYS_SIMDIR/submodules/alu.v \
  $QSYS_SIMDIR/submodules/aluSource.v \
  $QSYS_SIMDIR/submodules/controlUnit.v \
  $QSYS_SIMDIR/submodules/DRAM.v \
  $QSYS_SIMDIR/submodules/forwadingUnit.v \
  $QSYS_SIMDIR/submodules/FPU.v \
  $QSYS_SIMDIR/submodules/Fpu_Controller.v \
  $QSYS_SIMDIR/submodules/hdu.v \
  $QSYS_SIMDIR/submodules/immGen.v \
  $QSYS_SIMDIR/submodules/IRAM.v \
  $QSYS_SIMDIR/submodules/mux.v \
  $QSYS_SIMDIR/submodules/regFile.v \
  $QSYS_SIMDIR/submodules/fpu_add_sub.v \
  $QSYS_SIMDIR/submodules/fpu_compare.v \
  $QSYS_SIMDIR/submodules/fpu_convert.v \
  $QSYS_SIMDIR/submodules/fpu_convert_float_integer.v \
  $QSYS_SIMDIR/submodules/fpu_div.v \
  $QSYS_SIMDIR/submodules/fpu_mult.v \
  $QSYS_SIMDIR/submodules/fpu_sqrt.v \
  $QSYS_SIMDIR/system.v \
  -top $TOP_LEVEL_NAME
# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $USER_DEFINED_SIM_OPTIONS
fi
