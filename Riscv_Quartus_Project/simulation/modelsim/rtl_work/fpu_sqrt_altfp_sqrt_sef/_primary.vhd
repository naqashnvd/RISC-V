library verilog;
use verilog.vl_types.all;
entity fpu_sqrt_altfp_sqrt_sef is
    port(
        aclr            : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        nan             : out    vl_logic;
        overflow        : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic
    );
end fpu_sqrt_altfp_sqrt_sef;
