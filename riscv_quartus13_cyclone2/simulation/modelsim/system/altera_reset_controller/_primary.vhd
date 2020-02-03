library verilog;
use verilog.vl_types.all;
entity altera_reset_controller is
    generic(
        NUM_RESET_INPUTS: integer := 6;
        OUTPUT_RESET_SYNC_EDGES: string  := "deassert";
        SYNC_DEPTH      : integer := 2;
        RESET_REQUEST_PRESENT: integer := 0
    );
    port(
        reset_in0       : in     vl_logic;
        reset_in1       : in     vl_logic;
        reset_in2       : in     vl_logic;
        reset_in3       : in     vl_logic;
        reset_in4       : in     vl_logic;
        reset_in5       : in     vl_logic;
        reset_in6       : in     vl_logic;
        reset_in7       : in     vl_logic;
        reset_in8       : in     vl_logic;
        reset_in9       : in     vl_logic;
        reset_in10      : in     vl_logic;
        reset_in11      : in     vl_logic;
        reset_in12      : in     vl_logic;
        reset_in13      : in     vl_logic;
        reset_in14      : in     vl_logic;
        reset_in15      : in     vl_logic;
        clk             : in     vl_logic;
        reset_out       : out    vl_logic;
        reset_req       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_RESET_INPUTS : constant is 1;
    attribute mti_svvh_generic_type of OUTPUT_RESET_SYNC_EDGES : constant is 1;
    attribute mti_svvh_generic_type of SYNC_DEPTH : constant is 1;
    attribute mti_svvh_generic_type of RESET_REQUEST_PRESENT : constant is 1;
end altera_reset_controller;
