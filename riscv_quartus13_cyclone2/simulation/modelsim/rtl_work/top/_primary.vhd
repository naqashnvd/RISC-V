library verilog;
use verilog.vl_types.all;
entity top is
    port(
        CLOCK_24        : in     vl_logic;
        KEY             : in     vl_logic_vector(1 downto 1);
        SW              : in     vl_logic_vector(0 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0)
    );
end top;
