library verilog;
use verilog.vl_types.all;
entity fpu_compare is
    port(
        aclr            : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        datab           : in     vl_logic_vector(31 downto 0);
        aeb             : out    vl_logic;
        alb             : out    vl_logic;
        aleb            : out    vl_logic
    );
end fpu_compare;
