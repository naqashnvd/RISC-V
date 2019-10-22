library verilog;
use verilog.vl_types.all;
entity IRAM is
    generic(
        width           : integer := 8;
        addrWidth       : integer := 8
    );
    port(
        DOUT            : out    vl_logic_vector;
        ADDR            : in     vl_logic_vector;
        DIN             : in     vl_logic_vector;
        wren            : in     vl_logic;
        clear           : in     vl_logic;
        clk             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of addrWidth : constant is 1;
end IRAM;
