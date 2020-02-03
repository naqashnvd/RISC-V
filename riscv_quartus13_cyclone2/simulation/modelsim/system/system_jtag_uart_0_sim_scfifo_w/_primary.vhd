library verilog;
use verilog.vl_types.all;
entity system_jtag_uart_0_sim_scfifo_w is
    port(
        clk             : in     vl_logic;
        fifo_wdata      : in     vl_logic_vector(7 downto 0);
        fifo_wr         : in     vl_logic;
        fifo_FF         : out    vl_logic;
        r_dat           : out    vl_logic_vector(7 downto 0);
        wfifo_empty     : out    vl_logic;
        wfifo_used      : out    vl_logic_vector(5 downto 0)
    );
end system_jtag_uart_0_sim_scfifo_w;
