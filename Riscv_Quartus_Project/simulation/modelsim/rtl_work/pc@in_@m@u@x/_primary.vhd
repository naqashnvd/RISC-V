library verilog;
use verilog.vl_types.all;
entity pcIn_MUX is
    port(
        pcIn_sel        : in     vl_logic_vector(1 downto 0);
        \in\            : in     vl_logic_vector(95 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end pcIn_MUX;
