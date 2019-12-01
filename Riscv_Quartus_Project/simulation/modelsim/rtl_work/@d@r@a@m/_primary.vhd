library verilog;
use verilog.vl_types.all;
entity DRAM is
    generic(
        width           : integer := 32;
        addrWidth       : integer := 8
    );
    port(
        DOUT            : out    vl_logic_vector;
        ADDR            : in     vl_logic_vector;
        DIN             : in     vl_logic_vector;
        wren            : in     vl_logic;
        clock           : in     vl_logic;
        func3           : in     vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of addrWidth : constant is 1;
end DRAM;
