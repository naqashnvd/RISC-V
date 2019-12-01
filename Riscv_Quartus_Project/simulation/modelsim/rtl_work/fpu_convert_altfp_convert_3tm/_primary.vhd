library verilog;
use verilog.vl_types.all;
entity fpu_convert_altfp_convert_3tm is
    port(
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end fpu_convert_altfp_convert_3tm;
