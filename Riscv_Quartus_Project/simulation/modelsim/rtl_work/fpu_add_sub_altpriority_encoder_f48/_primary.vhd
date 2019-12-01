library verilog;
use verilog.vl_types.all;
entity fpu_add_sub_altpriority_encoder_f48 is
    port(
        data            : in     vl_logic_vector(15 downto 0);
        q               : out    vl_logic_vector(3 downto 0)
    );
end fpu_add_sub_altpriority_encoder_f48;
