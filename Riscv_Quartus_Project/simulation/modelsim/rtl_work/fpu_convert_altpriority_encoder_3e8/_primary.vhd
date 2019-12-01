library verilog;
use verilog.vl_types.all;
entity fpu_convert_altpriority_encoder_3e8 is
    port(
        data            : in     vl_logic_vector(1 downto 0);
        q               : out    vl_logic_vector(0 downto 0);
        zero            : out    vl_logic
    );
end fpu_convert_altpriority_encoder_3e8;
