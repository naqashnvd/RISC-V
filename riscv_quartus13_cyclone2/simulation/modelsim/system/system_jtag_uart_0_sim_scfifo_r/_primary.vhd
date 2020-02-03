library verilog;
use verilog.vl_types.all;
entity system_jtag_uart_0_sim_scfifo_r is
    port(
        clk             : in     vl_logic;
        fifo_rd         : in     vl_logic;
        rst_n           : in     vl_logic;
        fifo_EF         : out    vl_logic;
        fifo_rdata      : out    vl_logic_vector(7 downto 0);
        rfifo_full      : out    vl_logic;
        rfifo_used      : out    vl_logic_vector(5 downto 0)
    );
end system_jtag_uart_0_sim_scfifo_r;
