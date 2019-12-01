library verilog;
use verilog.vl_types.all;
entity fpu_add_sub_altfp_add_sub_hrm is
    port(
        add_sub         : in     vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        datab           : in     vl_logic_vector(31 downto 0);
        nan             : out    vl_logic;
        overflow        : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        underflow       : out    vl_logic;
        zero            : out    vl_logic
    );
end fpu_add_sub_altfp_add_sub_hrm;
