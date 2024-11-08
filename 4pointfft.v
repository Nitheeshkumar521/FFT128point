`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 19:50:45
// Design Name: 
// Module Name: two_point_fft_maths
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module performs two-point FFT operations using DSP for addition 
//              and subtraction of real and imaginary components.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module two_point_fft_maths#(
    parameter DATA_WIDTH = 4,  // Input width
              OUT_WIDTH = 5    // Output width
)(
    input CLK,
    input reset
);

    // Input signal initialization
    reg [DATA_WIDTH-1:0] real_inputs [1:0];
    reg [DATA_WIDTH-1:0] imag_inputs [1:0];

    initial begin
        real_inputs[0] = 4'b0011;  // 3
        real_inputs[1] = 4'b0001;  // 1
        imag_inputs[0] = 4'b0001;  // 1
        imag_inputs[1] = 4'b0010;  // 2
    end

    // Wire assignments for real and imaginary inputs
    wire [DATA_WIDTH-1:0] real_in_0, real_in_1, imag_in_0, imag_in_1;
    assign real_in_0 = real_inputs[0];
    assign real_in_1 = real_inputs[1];
    assign imag_in_0 = imag_inputs[0];
    assign imag_in_1 = imag_inputs[1];

    // Intermediate signals
    wire [OUT_WIDTH-1:0] real_sum, real_diff;
    wire [OUT_WIDTH-1:0] imag_sum, imag_diff;

    // DSP instantiation for real part sum (real_in_0 + real_in_1)
    dsp_macro_0 dsp_real_sum_inst (
      .CLK(CLK),           // input wire CLK
      .A(real_in_0),       // input wire [DATA_WIDTH-1:0] A
      .C(real_in_1),       // input wire [DATA_WIDTH-1:0] C
      .P(real_sum)         // output wire [OUT_WIDTH-1:0] P
    );

    // DSP instantiation for real part difference (real_in_0 - real_in_1)
    dsp_macro_1 dsp_real_diff_inst (
      .CLK(CLK),           // input wire CLK
      .A(real_in_0),       // input wire [DATA_WIDTH-1:0] A
      .C(real_in_1),       // input wire [DATA_WIDTH-1:0] C
      .P(real_diff)        // output wire [OUT_WIDTH-1:0] P
    );

    // DSP instantiation for imaginary part sum (imag_in_0 + imag_in_1)
    dsp_macro_0 dsp_imag_sum_inst (
      .CLK(CLK),           // input wire CLK
      .A(imag_in_0),       // input wire [DATA_WIDTH-1:0] A
      .C(imag_in_1),       // input wire [DATA_WIDTH-1:0] C
      .P(imag_sum)         // output wire [OUT_WIDTH-1:0] P
    );

    // DSP instantiation for imaginary part difference (imag_in_0 - imag_in_1)
    dsp_macro_1 dsp_imag_diff_inst (
      .CLK(CLK),           // input wire CLK
      .A(imag_in_0),       // input wire [DATA_WIDTH-1:0] A
      .C(imag_in_1),       // input wire [DATA_WIDTH-1:0] C
      .P(imag_diff)        // output wire [OUT_WIDTH-1:0] P
    );

    // Instantiating ILA for signal probing 
    ila_0 ila_instance (
        .clk(CLK),           // input wire clk
        .probe0(real_sum),   // input wire [OUT_WIDTH-1:0] probe0
        .probe1(real_diff),  // input wire [OUT_WIDTH-1:0] probe1
        .probe2(imag_sum),   // input wire [OUT_WIDTH-1:0] probe2
        .probe3(imag_diff)   // input wire [OUT_WIDTH-1:0] probe3
    );

endmodule
