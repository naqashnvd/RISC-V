library verilog;
use verilog.vl_types.all;
entity riscv is
    generic(
        width           : integer := 32
    );
    port(
        dataA           : in     vl_logic_vector;
        dataB           : in     vl_logic_vector;
        func            : in     vl_logic_vector(3 downto 0);
        aluOp           : in     vl_logic_vector(2 downto 0);
        aluResult       : out    vl_logic_vector;
        branchFromAlu   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end riscv;
