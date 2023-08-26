module tt_um_counter #( parameter MAX_COUNT = 10_000_000 )(
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
    reg out;
    //se asignaa cada cable el valor de la salida del decode
    assign loadPC = 1'b1;


    always @ (posedge clk, posedge reset, posedge load) begin
        if (load) out <= ui_in;// de lo contrario se revisa reset si es un entonces la salida es 0
        else 
            if (reset) out <= 0;//de lo contrario se revisa enable y si es 1 la salida se le aumenta 1
            else if(enable) out <= out + 1;// si es 1 entonces se asigna el valor cargado a la salida
            else out <= out;
    end
    assign uo_out = out;
endmodule
