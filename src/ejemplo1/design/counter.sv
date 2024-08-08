// ----------------------------------------------------------------------------------------------------
//    Herramientas de flujo de diseño con vivado (2019.1)
// ----------------------------------------------------------------------------------------------------
// --
// -- Componente:  Ejemplo - contador 16 bits
// -- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
// -- Archivo:     counter.sv
// -- Descripcion: Ejemplo contador
// --
// ----------------------------------------------------------------------------------------------------
// -- Revision    Fecha        Revisor    Comentarios
// -- 0           27-03-2023   PMP        Original
// ----------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps
module counter (
    input logic         clk_i,
    input logic         rst_i,
    input logic         en_i,
    output logic [15:0] counter_o
);

always_ff @( posedge clk_i ) begin : main_counter
    if(!rst_i) begin
        counter_o <= '0;
    end else begin
        if(en_i)
            counter_o <= counter_o + 1'b1;
    end
end

endmodule

