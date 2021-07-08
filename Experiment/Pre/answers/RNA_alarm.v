`timescale 1ns / 1ps

module RSA_alarm(
    input clk,
    input reset,
    input [7:0] base,
    output danger,
    output reg [3:0] counter
    );

    reg [7:0] s[0:5];
    reg halt;

    assign hit = {s[0], s[1], s[2], s[3], s[4], s[5]} == "ATATGC" && base == "G";
    assign danger = halt || hit;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            s[0] <= 0;
            s[1] <= 0;
            s[2] <= 0;
            s[3] <= 0;
            s[4] <= 0;
            s[5] <= 0;
            halt <= 0;
            counter <= 0;
        end else if (halt) begin
            s[0] <= s[0];
            s[1] <= s[1];
            s[2] <= s[2];
            s[3] <= s[3];
            s[4] <= s[4];
            s[5] <= s[5];
            halt <= halt;
            counter <= counter;
        end else begin
            s[0] <= s[1];
            s[1] <= s[2];
            s[2] <= s[3];
            s[3] <= s[4];
            s[4] <= s[5];
            s[5] <= base;
            halt <= counter == 6 && hit;
            counter <= hit ? counter + 1 : counter;
        end
    end

endmodule