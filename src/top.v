module tt_um_counter #( parameter MAX_COUNT = 10_000_000 )
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    // estos con cables que son usados para conectar las salidas de decode
    wire loadPC;
    wire counter_value;
    wire count;
    //se asignaa cada cable el valor de la salida del decode
    assign loadPC = 1'b1;
    assign counter_value = ui_in;
    assign counter = uo_out;
    
    //------------------ CONTROL DEL PROGRAMA -------------------------------
    Contador8b programCouter(loadPC, ena, clk, rst_n, counter_value, count); //program counter

endmodule
