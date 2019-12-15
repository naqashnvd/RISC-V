library verilog;
use verilog.vl_types.all;
entity forwardingUnit is
    port(
        MEM_RegWrite    : in     vl_logic;
        WB_RegWrite     : in     vl_logic;
        MEM_Rd          : in     vl_logic_vector(4 downto 0);
        EX_Rs1          : in     vl_logic_vector(4 downto 0);
        EX_Rs2          : in     vl_logic_vector(4 downto 0);
        WB_Rd           : in     vl_logic_vector(4 downto 0);
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0)
    );
end forwardingUnit;
