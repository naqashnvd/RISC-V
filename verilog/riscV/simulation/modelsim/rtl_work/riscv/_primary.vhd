library verilog;
use verilog.vl_types.all;
entity riscv is
    port(
        KEY             : in     vl_logic_vector(1 downto 0)
    );
end riscv;
