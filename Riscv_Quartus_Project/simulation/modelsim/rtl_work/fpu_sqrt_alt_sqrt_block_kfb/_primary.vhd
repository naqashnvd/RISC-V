library verilog;
use verilog.vl_types.all;
entity fpu_sqrt_alt_sqrt_block_kfb is
    port(
        aclr            : in     vl_logic;
        clken           : in     vl_logic;
        clock           : in     vl_logic;
        rad             : in     vl_logic_vector(25 downto 0);
        root_result     : out    vl_logic_vector(24 downto 0)
    );
end fpu_sqrt_alt_sqrt_block_kfb;
