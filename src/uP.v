`default_nettype none

module tt_um_uP #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   // estos con cables que son usados para conectar las salidas de decode
    wire [3:0] pushbuttons;          
    wire [7:0] program_byte;
    wire [11:0] PC, address_RAM;         
    wire [3:0] instr, oprnd, data_bus, FF_out, accu; 
    wire clock;
    wire reset;
    wire phase;
    wire c_flag;
    wire z_flag; 
    wire loadPC;
    wire incPC;
    wire loadA;
    wire loadFlags;
    wire [2:0] opALU;
    wire cs;
    wire we;
    wire oeALU;
    wire oeIn;
    wire oeOprnd;
    wire loadOut;
    wire [12:0] outDecode;
    wire [6:0] inDecode;
  
    // Assign the input.
    assign uio_out = 8'h00;
    assign uo_out = 8'h00;
    assign uio_oe = 8'h00;
  
    assign reset = ! rst_n;
    assign clock = clk;
    assign pushbuttons = ui_in[0:3];

    assign inDecode = {instr, c_flag,z_flag,phase}; 
    
    Decode dec(inDecode, outDecode);
    //se asignaa cada cable el valor de la salida del decode
    assign incPC = outDecode[12];
    assign loadPC = outDecode[11];
    assign loadA = outDecode[10];
    assign loadFlags = outDecode[9];
    assign opALU = outDecode[8:6];
    assign cs = outDecode[5];
    assign we = outDecode[4];
    assign oeALU = outDecode[3];
    assign oeIn = outDecode [2];
    assign oeOprnd = outDecode [1];
    assign loadOut = outDecode[0];

    assign address_RAM = {oprnd,program_byte};
    //------------------ CONTROL DEL PROGRAMA -------------------------------
    Contador12b programCouter(loadPC,incPC, clock, reset, address_RAM, PC ); //program counter
    Memory  programROM(PC, program_byte); // memoria de programa
    FlipFlopD4b fetchOp(program_byte[3:0], ~phase, reset, clock, oprnd);
    FlipFlopD4b  fetchIns(program_byte[7:4], ~phase, reset, clock, instr);
    FlipFlopT   fase(1'b1, reset, clock, phase);
    //-----------------------------------------------------------------------
    //------------------- MANEJO DE DATOS------------------------------------
    wire[3:0] outAlu;
    wire c,z;
    Triestate bufferOprnd(oprnd,oeOprnd,data_bus);
    Triestate bufferIn(pushbuttons,oeIn,data_bus);
    Triestate bufferAlu(outAlu,oeALU, data_bus);

    RAM ram(address_RAM,cs,we,data_bus);
    //------------------- ALU ----------------------------------------------
    FlipFlopD4b accumulador(outAlu, loadA,reset, clock, accu );
    ALU unidadAritmetica(accu,data_bus, opALU, outAlu,c , z);

    FlipFlopD1b flagsC(c,loadFlags,reset, clock, c_flag);
    FlipFlopD1b flagsZ(z,loadFlags,reset, clock, z_flag);
    //--------------- Salida -----------------------------------------------
    FlipFlopD4b salida(data_bus,loadOut, reset, clock, FF_out);

    assign uo_out[0:3] = FF_out;

endmodule
