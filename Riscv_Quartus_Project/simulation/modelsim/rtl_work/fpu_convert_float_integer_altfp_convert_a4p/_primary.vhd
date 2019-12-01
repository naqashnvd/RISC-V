library verilog;
use verilog.vl_types.all;
entity fpu_convert_float_integer_altfp_convert_a4p is
    port(
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        nan             : out    vl_logic;
        overflow        : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        underflow       : out    vl_logic
    );
end fpu_convert_float_integer_altfp_convert_a4p;
