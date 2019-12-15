library verilog;
use verilog.vl_types.all;
entity fpu_convert_altpriority_encoder_qb6 is
    port(
        data            : in     vl_logic_vector(31 downto 0);
        q               : out    vl_logic_vector(4 downto 0)
    );
end fpu_convert_altpriority_encoder_qb6;
