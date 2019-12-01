library verilog;
use verilog.vl_types.all;
entity HDU is
    port(
        EX_MemRead      : in     vl_logic;
        ID_Rs1          : in     vl_logic_vector(4 downto 0);
        ID_Rs2          : in     vl_logic_vector(4 downto 0);
        EX_Rd           : in     vl_logic_vector(4 downto 0);
        notStall        : out    vl_logic
    );
end HDU;
