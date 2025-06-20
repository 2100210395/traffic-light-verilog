`timescale 1ns / 1ps
`define RED     2'd0
`define YELLOW  2'd1
`define GREEN   2'd2

`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

`define Y2RDELAY 3  // Delay after yellow before red
`define R2GDELAY 2  // Delay after red before green

module traffic_controller (
    output reg [1:0] hwy,
    output reg [1:0] cntry,
    input wire X,
    input wire clock,
    input wire clear
);

reg [2:0] state, next_state;
reg [2:0] counter;  // For delay counting

// State register with reset
always @(posedge clock or posedge clear) begin
    if (clear)
        state <= `S0;
    else
        state <= next_state;
end

// Output logic based on current state
always @(*) begin
    case (state)
        `S0: begin hwy = `GREEN;  cntry = `RED;    end
        `S1: begin hwy = `YELLOW; cntry = `RED;    end
        `S2: begin hwy = `RED;    cntry = `RED;    end
        `S3: begin hwy = `RED;    cntry = `GREEN;  end
        `S4: begin hwy = `RED;    cntry = `YELLOW; end
       // default: begin hwy = `RED; cntry = `RED;   end
    endcase
end

// Counter logic
always @(posedge clock or posedge clear) begin
    if (clear)
        counter <= 0;
    else if ((state == `S1 && next_state == `S1) ||
             (state == `S2 && next_state == `S2) ||
             (state == `S4 && next_state == `S4))
        counter <= counter + 1;
    else
        counter <= 0;
end

// Next-state logic
always @(*) begin
    case (state)
        `S0: next_state = (X) ? `S1 : `S0;

        `S1: next_state = (counter >= `Y2RDELAY) ? `S2 : `S1;

        `S2: next_state = (counter >= `R2GDELAY) ? `S3 : `S2;

        `S3: next_state = (X) ? `S3 : `S4;

        `S4: next_state = (counter >= `Y2RDELAY) ? `S0 : `S4;

        default: next_state = `S0;
    endcase
end

endmodule


