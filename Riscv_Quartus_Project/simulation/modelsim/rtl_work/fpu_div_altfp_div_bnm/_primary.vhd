library verilog;
use verilog.vl_types.all;
entity fpu_div_altfp_div_bnm is
    port(
        aclr            : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        datab           : in     vl_logic_vector(31 downto 0);
        division_by_zero: out    vl_logic;
        nan             : out    vl_logic;
        overflow        : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        underflow       : out    vl_logic;
        zero            : out    vl_logic
    );
end fpu_div_altfp_div_bnm;
