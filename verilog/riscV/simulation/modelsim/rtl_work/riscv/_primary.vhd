library verilog;
use verilog.vl_types.all;
entity riscv is
    port(
        clock           : in     vl_logic;
        clear           : in     vl_logic
    );
end riscv;
