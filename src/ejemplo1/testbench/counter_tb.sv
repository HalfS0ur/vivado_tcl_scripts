// ----------------------------------------------------------------------------------------------------
//    Herramientas de flujo de diseño con vivado (2019.1)
// ----------------------------------------------------------------------------------------------------
// --
// -- Componente:  Ejemplo - contador 16 bits
// -- Autor:       Pablo Mendoza Ponce (pmendoza@itcr.ac.cr)
// -- Archivo:     counter_tb.sv
// -- Descripcion: Ejemplo contador
// --
// ----------------------------------------------------------------------------------------------------
// -- Revision    Fecha        Revisor    Comentarios
// -- 0           27-03-2023   PMP        Original
// ----------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps
module counter_tb;

    logic           clk;
    logic           rst;
    logic           en;
    logic [15:0]    counter;
    logic [15:0]    counter_l;

    counter dut (
        .clk_i      (clk),
        .rst_i      (rst),
        .en_i       (en),
        .counter_o  (counter)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1'b0;
        en = 1'b0;
        counter_l = '0;
        #100;

        @(posedge clk);
        rst  <= 1;
        @(posedge clk);
        @(posedge clk);
        if(counter != 16'd0) begin
            $display("%t ERROR counting with en=0", $time);
            #10;
            $finish;
        end
        
        @(posedge clk);
        en <= 1'b1;
        @(posedge clk);
        counter_l = counter;
        @(posedge clk);

        repeat(10) begin
            counter_l = counter_l + 1'b1;

            if(counter_l != counter) begin
                $display("%t ERROR not counting with en=1", $time);
                #10;
                $finish;
            end

            counter_l = counter;
            @(posedge clk);
        end
       
        #10;
        $display("%t No errors detected - finishing", $time);
        $finish;
    end

endmodule