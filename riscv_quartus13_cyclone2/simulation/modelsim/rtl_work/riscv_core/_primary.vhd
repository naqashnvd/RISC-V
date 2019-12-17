library verilog;
use verilog.vl_types.all;
entity riscv_core is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        av_chipselect   : out    vl_logic;
        av_address      : out    vl_logic;
        av_read_n       : out    vl_logic;
        av_readdata     : in     vl_logic_vector(31 downto 0);
        av_write_n      : out    vl_logic;
        av_writedata    : out    vl_logic_vector(31 downto 0);
        av_waitrequest  : in     vl_logic;
        dataOut         : out    vl_logic_vector(31 downto 0)
    );
end riscv_core;
