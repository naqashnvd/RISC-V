library verilog;
use verilog.vl_types.all;
entity controlUnit is
    port(
        opcode          : in     vl_logic_vector(6 downto 0);
        signals         : out    vl_logic_vector(10 downto 0)
    );
end controlUnit;
