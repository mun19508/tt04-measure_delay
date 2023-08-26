module tt_um_counter(
    input  wire ui_in,    // Dedicated inputs
    output wire uo_out,   // Dedicated outputs
);
    not n1(uo_out,ui_in);
endmodule
