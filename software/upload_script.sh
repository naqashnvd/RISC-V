#!/bin/bash
cd C:\\Users\\naqas\\Desktop\\Github\\RISC-V1\\riscv_quartus13_cyclone2
quartus_cdb --update_mif top #quartus_cdb --update_mif <project name>
quartus_asm top #quartus_asm <project name>
cd output_files/
quartus_pgm -c USB-Blaster Chain3.cdf
cd ../../software/
nios2-terminal | python Display_Float.py
