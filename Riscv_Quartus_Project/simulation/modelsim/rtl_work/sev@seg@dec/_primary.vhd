library verilog;
use verilog.vl_types.all;
entity sevSegDec is
    port(
        bcd             : in     vl_logic_vector(3 downto 0);
        seg             : out    vl_logic_vector(6 downto 0)
    );
end sevSegDec;
