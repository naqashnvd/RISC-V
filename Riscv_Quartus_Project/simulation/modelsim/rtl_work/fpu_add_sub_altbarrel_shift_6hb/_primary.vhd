library verilog;
use verilog.vl_types.all;
entity fpu_add_sub_altbarrel_shift_6hb is
    port(
        data            : in     vl_logic_vector(25 downto 0);
        distance        : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(25 downto 0)
    );
end fpu_add_sub_altbarrel_shift_6hb;
