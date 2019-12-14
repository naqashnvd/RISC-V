library verilog;
use verilog.vl_types.all;
entity fpu_add_sub is
    port(
        aclr            : in     vl_logic;
        add_sub         : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        datab           : in     vl_logic_vector(31 downto 0);
        nan             : out    vl_logic;
        overflow        : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        underflow       : out    vl_logic;
        zero            : out    vl_logic
    );
end fpu_add_sub;
