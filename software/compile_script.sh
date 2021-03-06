#!/bin/bash
riscv64-unknown-elf-gcc test.c -nostdlib -T link_simple.ld -march=rv32if -mabi=ilp32f  -o test.elf 
riscv64-unknown-elf-objdump -D test.elf  > test.txt
riscv64-unknown-elf-objdump -d -w test.elf | sed '1,7d' > temp_imem.txt
riscv64-unknown-elf-objdump -s -j .rodata test.elf | sed '1,4d' > temp_dmem.txt
python memory_script.py
cp dmem.hex ../riscv_core/
cp imem.hex ../riscv_core/
cp dmem.hex ../riscv_quartus13_cyclone2/simulation/modelsim/
cp imem.hex ../riscv_quartus13_cyclone2/simulation/modelsim/
cp dmem.hex ../riscv_quartus13_cyclone2/system/simulation/submodules/
cp imem.hex ../riscv_quartus13_cyclone2/system/simulation/submodules/
cp dmem.hex ../riscv_quartus13_cyclone2/system/synthesis/submodules/
cp imem.hex ../riscv_quartus13_cyclone2/system/synthesis/submodules/
mv top.ram0_IRAM_c4ed6c1d.hdl.mif ../riscv_quartus13_cyclone2/db/
mv top.ram0_DRAM_df80aefc.hdl.mif ../riscv_quartus13_cyclone2/db/
rm dmem.hex
rm imem.hex 
rm temp_dmem.txt
rm temp_imem.txt






