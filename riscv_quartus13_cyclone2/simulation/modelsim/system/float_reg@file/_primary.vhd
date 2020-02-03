library verilog;
use verilog.vl_types.all;
entity float_regFile is
    generic(
        width           : integer := 32;
        addrWidth       : integer := 5
    );
    port(
        clock           : in     vl_logic;
        regWriteEnable  : in     vl_logic;
        addrA           : in     vl_logic_vector;
        addrB           : in     vl_logic_vector;
        addrfrs3        : in     vl_logic_vector;
        addrD           : in     vl_logic_vector;
        dataD           : in     vl_logic_vector;
        dataA           : out    vl_logic_vector;
        dataB           : out    vl_logic_vector;
        datafrs3        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of addrWidth : constant is 1;
end float_regFile;
