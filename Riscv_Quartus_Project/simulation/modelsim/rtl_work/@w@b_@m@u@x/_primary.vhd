library verilog;
use verilog.vl_types.all;
entity WB_MUX is
    port(
        WB_sel          : in     vl_logic_vector(1 downto 0);
        \in\            : in     vl_logic_vector(127 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end WB_MUX;
