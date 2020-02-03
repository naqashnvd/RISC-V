library verilog;
use verilog.vl_types.all;
entity FPU is
    generic(
        width           : integer := 32
    );
    port(
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        fpu_sel         : in     vl_logic;
        dataA           : in     vl_logic_vector;
        dataB           : in     vl_logic_vector;
        datafrs3        : in     vl_logic_vector;
        func3           : in     vl_logic_vector(2 downto 0);
        fpuOp           : in     vl_logic_vector(3 downto 0);
        EX_Rs2_0        : in     vl_logic;
        fpuResult       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end FPU;
