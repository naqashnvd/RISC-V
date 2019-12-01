library verilog;
use verilog.vl_types.all;
entity fpu_compare_altfp_compare_irb is
    port(
        aeb             : out    vl_logic;
        alb             : out    vl_logic;
        aleb            : out    vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        datab           : in     vl_logic_vector(31 downto 0)
    );
end fpu_compare_altfp_compare_irb;
