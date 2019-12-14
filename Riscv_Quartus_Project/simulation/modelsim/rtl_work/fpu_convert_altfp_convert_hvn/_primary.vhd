library verilog;
use verilog.vl_types.all;
entity fpu_convert_altfp_convert_hvn is
    port(
        aclr            : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end fpu_convert_altfp_convert_hvn;
