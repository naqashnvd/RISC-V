library verilog;
use verilog.vl_types.all;
entity riscv_core is
    port(
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        dataOut         : out    vl_logic_vector(31 downto 0)
    );
end riscv_core;
