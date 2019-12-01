library verilog;
use verilog.vl_types.all;
entity fpu_convert is
    port(
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end fpu_convert;
