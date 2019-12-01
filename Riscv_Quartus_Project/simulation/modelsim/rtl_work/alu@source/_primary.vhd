library verilog;
use verilog.vl_types.all;
entity aluSource is
    port(
        EX_dataA        : in     vl_logic_vector(31 downto 0);
        dataD           : in     vl_logic_vector(31 downto 0);
        MEM_aluResult   : in     vl_logic_vector(31 downto 0);
        EX_dataB        : in     vl_logic_vector(31 downto 0);
        EX_immGenOut    : in     vl_logic_vector(31 downto 0);
        forwardA        : in     vl_logic_vector(1 downto 0);
        forwardB        : in     vl_logic_vector(1 downto 0);
        aluSourceSel    : in     vl_logic;
        aluA            : out    vl_logic_vector(31 downto 0);
        aluB            : out    vl_logic_vector(31 downto 0);
        forwardB_dataB  : out    vl_logic_vector(31 downto 0)
    );
end aluSource;
