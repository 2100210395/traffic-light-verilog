`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2025 22:19:17
// Design Name: 
// Module Name: tb_traffic_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_traffic_controller;
  reg clock = 0, clear = 1, X = 0;
  wire [1:0] hwy, cntry;

  traffic_controller uut(hwy, cntry, X, clock, clear);

  always #5 clock = ~clock;

  initial begin
    $monitor("Time: %0t | HWY: %b | CNTRY: %b | X: %b", $time, hwy, cntry, X);

    #10 clear = 0;     // Deassert reset
    #50 X = 1;         // Car on country road
    #200 X = 0;  
   
          // No more car
    #300 $finish;
  end
endmodule


