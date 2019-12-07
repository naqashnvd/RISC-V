library verilog;
use verilog.vl_types.all;
entity fpuController is
    port(
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        fpuOp           : in     vl_logic_vector(3 downto 0);
        fpu_sel         : in     vl_logic;
        fpu_inprogress  : out    vl_logic
    );
end fpuController;
