library verilog;
use verilog.vl_types.all;
entity pc is
    generic(
        width           : integer := 32
    );
    port(
        data            : in     vl_logic_vector;
        enable          : in     vl_logic;
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end pc;
