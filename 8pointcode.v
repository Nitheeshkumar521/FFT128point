module FFTeight(

input wire clk, 
input wire [21:0] r0, r1, r2, r3, r4, r5, r6, r7,i0, i1, i2, i3, i4, i5, i6, i7,
output wire [36:0] R0, R1, R2, R3, R4, R5, R6, R7, I0, I1, I2, I3, I4, I5, I6, I7

);

wire[27:0] br0, br1, br2, br3, br4, br5, br6, br7, bi0, bi1, bi2, bi3, bi4, bi5, bi6, bi7;

// Twiddle factor values for stage 1 of 8-point FFT in 8-bit fixed-point binary format
parameter signed [7:0] W0_real = 8'b01111111; // 1
parameter signed [7:0] W0_imag = 8'b00000000; // 0

parameter signed [7:0] W1_real = 8'b01011010; // 0.707 (approx 90)
parameter signed [7:0] W1_imag = 8'b10100110; // -0.707 (approx -90)

parameter signed [7:0] W2_real = 8'b00000000; // 0
parameter signed [7:0] W2_imag = 8'b10000000; // -1

parameter signed [7:0] W3_real = 8'b10100110; // -0.707 (approx -90)
parameter signed [7:0] W3_imag = 8'b10100110; // -0.707 (approx -90)

    assign br0 = r0 + r4;
    assign bi0 = i0 + i4;
    
wire [27:0] t1,t2,t3,t4;
    
    dsp_macro_1 your_instance_name (
      .CLK(clk),  // input wire CLK
      .A(r0 - r4),      // input wire [7 : 0] A  
      .B(W0_real),      // input wire [7 : 0] B
      .P(t1)      // output wire [15 : 0] P
    ); //performs A*B operation
    
      dsp_macro_1 a (
            .CLK(clk),  // input wire CLK
            .A(i0 - i4),      // input wire [7 : 0] A  
            .B(W0_real),      // input wire [7 : 0] B
            .P(t2)      // output wire [15 : 0] P
          ); //performs A*B operation
          
      dsp_macro_1 b (
        .CLK(clk),  // input wire CLK
        .A(i0 - i4),      // input wire [7 : 0] A  
        .B(W0_real),      // input wire [7 : 0] B
        .P(t3)      // output wire [15 : 0] P
      ); //performs A*B operation
      
          dsp_macro_1 c (
            .CLK(clk),  // input wire CLK
            .A(r0 - r4),      // input wire [7 : 0] A  
            .B(W0_imag),      // input wire [7 : 0] B
            .P(t4)      // output wire [15 : 0] P
          ); //performs A*B operation

    assign br4 = (t1 - t2 ) >>> 15;
    assign bi4 = (t3 + t4 ) >>> 15;

    assign br1 = r1 + r5;
    assign bi1 = i1 + i5;
    
    wire [27:0] t5,t6,t7,t8;
    
     dsp_macro_1 d (
               .CLK(clk),  // input wire CLK
               .A(r1 - r5),      // input wire [7 : 0] A  
               .B(W1_real),      // input wire [7 : 0] B
               .P(t5)      // output wire [15 : 0] P
             ); //performs A*B operation
    
     dsp_macro_1 e (
                        .CLK(clk),  // input wire CLK
                        .A(i1 - i5),      // input wire [7 : 0] A  
                        .B(W1_imag),      // input wire [7 : 0] B
                        .P(t6)      // output wire [15 : 0] P
                      ); //performs A*B operation
                      
      dsp_macro_1 f(
                                 .CLK(clk),  // input wire CLK
                                 .A(i1 - i5),      // input wire [7 : 0] A  
                                 .B(W1_real),      // input wire [7 : 0] B
                                 .P(t7)      // output wire [15 : 0] P
                               ); //performs A*B operation
      dsp_macro_1 g (
                                          .CLK(clk),  // input wire CLK
                                          .A(r1 - r5),      // input wire [7 : 0] A  
                                          .B(W1_imag),      // input wire [7 : 0] B
                                          .P(t8)      // output wire [15 : 0] P
                                        ); //performs A*B operation
    assign br5 = (t5 - t6) >>> 15;
    assign bi5 = t7+t8 >>> 15;

    assign br2 = r2 + r6;
    assign bi2 = i2 + i6;
    
    wire [27:0] t9,t10,t11,t12;
    
     dsp_macro_1 h (
         .CLK(clk),  // input wire CLK
         .A(r2 - r6),      // input wire [7 : 0] A  
         .B(W2_real),      // input wire [7 : 0] B
         .P(t9)      // output wire [15 : 0] P
       ); //performs A*B operation
       
        dsp_macro_1 i (
            .CLK(clk),  // input wire CLK
            .A(i2 - i6),      // input wire [7 : 0] A  
            .B(W2_imag),      // input wire [7 : 0] B
            .P(t10)      // output wire [15 : 0] P
          ); //performs A*B operation
          
          dsp_macro_1 j (
               .CLK(clk),  // input wire CLK
               .A(i2 - i6),      // input wire [7 : 0] A  
               .B(W2_real),      // input wire [7 : 0] B
               .P(t11)      // output wire [15 : 0] P
             ); //performs A*B operation
             
              dsp_macro_1 k (
                  .CLK(clk),  // input wire CLK
                  .A(r2 - r6),      // input wire [7 : 0] A  
                  .B(W2_imag),      // input wire [7 : 0] B
                  .P(t12)      // output wire [15 : 0] P
                ); //performs A*B operation
                 

    assign br6 = (t9 - t10) >>> 15;
    assign bi6 = (t11 + t12) >>> 15;

    assign br3 = r3 + r7;
    assign bi3 = i3 + i7;
    
             wire [27:0] t13,t14,t15,t16;
     dsp_macro_1 l (
         .CLK(clk),  // input wire CLK
         .A(r3 - r7),      // input wire [7 : 0] A  
         .B(W3_real),      // input wire [7 : 0] B
         .P(t13)      // output wire [15 : 0] P
       ); //performs A*B operation
                  
        dsp_macro_1 m(
            .CLK(clk),  // input wire CLK
            .A(i3 - i7),      // input wire [7 : 0] A  
            .B(W3_imag),      // input wire [7 : 0] B
            .P(t14)      // output wire [15 : 0] P
          ); //performs A*B operation
                    
           dsp_macro_1 n(
               .CLK(clk),  // input wire CLK
               .A(i3 - i7),      // input wire [7 : 0] A  
               .B(W3_real),      // input wire [7 : 0] B
               .P(t15)      // output wire [15 : 0] P
             ); //performs A*B operation
                       
              dsp_macro_1 o (
                  .CLK(clk),  // input wire CLK
                  .A(r3 - r7),      // input wire [7 : 0] A  
                  .B(W3_imag),      // input wire [7 : 0] B
                  .P(t16)      // output wire [15 : 0] P
                ); //performs A*B operation
               

    assign br7 = (t13 - t14) >>> 15;
    assign bi7 = (t15 + t16) >>> 15;


/*dsp_macro_0 your_instance_name (
  .CLK(clk),  // input wire CLK
  .A(),      // input wire [7 : 0] A
  .B(),      // input wire [7 : 0] B
  .P()      // output wire [15 : 0] P
);*/

 wire signed [35:0] ar0, ar1, ar2, ar3,ar4, ar5, ar6, ar7; // Intermediate real outputs
 wire signed [35:0] ai0, ai1, ai2, ai3,ai4, ai5, ai6, ai7;

//////////first 4 pt///////////////////////////////////////////////////////////////////////////////
///////stage 1//////////
assign ar0 = br0 + br2;                          // Real output for ar0
    assign ai0 = bi0 + bi2;                          // Imaginary output for ai0

    assign ar1 = br1 + br3;                          // Real output for ar1
    assign ai1 = bi1 + bi3;                          // Imaginary output for ai1

    assign ar2 = br0 - br2;                          // Real output for ar2
    assign ai2 = bi0 - bi2;                          // Imaginary output for ai2

    assign ar3 = (br1 - br3) * W1_real - (bi1 - bi3) * W1_imag; // Real output for ar3
    assign ai3 = (bi1 - bi3) * W1_real + (br1 - br3) * W1_imag;
/////////stage 2//////////or 2 pt fft///////////////////
    assign R0=ar0+ar1;
    assign R1=ar2+ar3;
    assign R2=ar0-ar1;
    assign R3=ar2-ar3;

   assign I0=ai0+ai1;
   assign I1=ai2+ai3;
   assign I2=ai0-ai1;
   assign I3=ai2-ai3;

////////second 4 pt///////////////////////////////////////////////////////////////////////////////
////////stage 1////////////
assign ar4 = br4 + br6;                     // Real output for ar4
    assign ai4 = bi4 + bi6;                     // Imaginary output for ai4

    assign ar5 = br5 + br7;                     // Real output for ar5
    assign ai5 = bi5 + bi7;                     // Imaginary output for ai5

    assign ar6 = br4 - br6;                     // Real output for ar6
    assign ai6 = bi4 - bi6;                     // Imaginary output for ai6

    assign ar7 = (br5 - br7) * W1_real >>> 8 - (bi5 - bi7) * W1_imag >>> 8; // Real output for ar7
    assign ai7 = (bi5 - bi7) * W1_real >>> 8 + (br5 - br7) * W1_imag >>> 8; // Imaginary output for ai7

/////////////Stage 2/////////////or 2 pt fft///////////////////////
assign R4 = ar4 + ar5;
assign R5 = ar6 + ar7;
assign R6 = ar4 - ar5;
assign R7 = ar6 - ar7;

assign I4 = ai4 + ai5;
assign I5 = ai6 + ai7;
assign I6 = ai4 - ai5;
assign I7 = ai6 - ai7;


endmodule



8 pt