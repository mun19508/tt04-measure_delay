`default_nettype none

module tt_um_chip_SP_measure_delay(
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // rst_n_n - low to rst_n
);

// Assign the input.
assign uio_out = 8'h00;
assign uio_oe = 8'h00;
assign uo_out[7:3] = 5'h00;

wire W_1;
wire W_2;
wire W_3;

wire EN;
wire EN_2;

assign uo_out[0] = W_1;
assign uo_out[1] = W_2;
assign uo_out[2] = W_3;


// Ring Oscilator, tiny tapeout does not synthesize this correctly.     
assign EN = ui_in[0];
assign EN_2 = ui_in[1];

and_cell U1(EN,EN_2,W_1);
not_cell U2(W_1,W_2);
not_cell  U3(W_2,W_3);
not_cell  U4(W_3,W_1);

endmodule


