library verilog;
use verilog.vl_types.all;
entity memOut_MUX is
    port(
        memOut_sel      : in     vl_logic_vector(2 downto 0);
        \in\            : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end memOut_MUX;
