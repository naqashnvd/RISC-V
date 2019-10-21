library verilog;
use verilog.vl_types.all;
entity immGen is
    generic(
        width           : integer := 32
    );
    port(
        I               : in     vl_logic_vector;
        immSel          : in     vl_logic_vector(1 downto 0);
        imm             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end immGen;
