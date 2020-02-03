library verilog;
use verilog.vl_types.all;
entity system is
    port(
        dataout_export  : out    vl_logic_vector(31 downto 0);
        clk_0_clk       : in     vl_logic;
        reset_0_reset_n : in     vl_logic
    );
end system;
