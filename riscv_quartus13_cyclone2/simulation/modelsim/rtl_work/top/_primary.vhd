library verilog;
use verilog.vl_types.all;
entity top is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(1 downto 1);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0)
    );
end top;
