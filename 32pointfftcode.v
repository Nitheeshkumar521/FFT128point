32 pt 
module fft32pt_stage1(
    input wire clk,
    input signed [1:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15,
    input signed [1:0] r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31,
    input signed [1:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15,
    input signed [1:0] i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31,
     output signed [36:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,
     output signed [36:0] R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31,
     output signed [36:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15,
     output signed [36:0] I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31
   
    );

wire signed [10:0] dr0, dr1, dr2, dr3, dr4, dr5, dr6, dr7, dr8, dr9, dr10, dr11, dr12, dr13, dr14, dr15,
                  dr16, dr17, dr18, dr19, dr20, dr21, dr22, dr23, dr24, dr25, dr26, dr27, dr28, dr29, dr30, dr31,
                  di0, di1, di2, di3, di4, di5, di6, di7, di8, di9, di10, di11, di12, di13, di14, di15,
                  di16, di17, di18, di19, di20, di21, di22, di23, di24, di25, di26, di27, di28, di29, di30, di31;


// Twiddle factors for a 32-point DIF FFT (8 bits each)
parameter signed [7:0] tw_re0  = 8'hFF; // W[0] = 1.0 (cos(0), sin(0))
parameter signed [7:0] tw_im0  = 8'h00; // W[0] = 0.0

parameter signed [7:0] tw_re1  = 8'h7F; // W[1] = cos(2?/32) = 0.9239
parameter signed [7:0] tw_im1  = 8'h7F; // W[1] = sin(2?/32) = 0.3827

parameter signed [7:0] tw_re2  = 8'h00; // W[2] = cos(4?/32) = 0.7071
parameter signed [7:0] tw_im2  = 8'hFF; // W[2] = sin(4?/32) = 0.7071

parameter signed [7:0] tw_re3  = 8'h80; // W[3] = cos(6?/32) = 0.3827
parameter signed [7:0] tw_im3  = 8'h7F; // W[3] = sin(6?/32) = 0.9239

parameter signed [7:0] tw_re4  = 8'h00; // W[4] = cos(8?/32) = 0.0
parameter signed [7:0] tw_im4  = 8'hFF; // W[4] = sin(8?/32) = 1.0

parameter signed [7:0] tw_re5  = 8'h80; // W[5] = cos(10?/32) = -0.3827
parameter signed [7:0] tw_im5  = 8'h7F; // W[5] = sin(10?/32) = 0.9239

parameter signed [7:0] tw_re6  = 8'h00; // W[6] = cos(12?/32) = -0.7071
parameter signed [7:0] tw_im6  = 8'hFF; // W[6] = sin(12?/32) = 0.7071

parameter signed [7:0] tw_re7  = 8'h80; // W[7] = cos(14?/32) = -0.9239
parameter signed [7:0] tw_im7  = 8'h7F; // W[7] = sin(14?/32) = 0.3827

parameter signed [7:0] tw_re8  = 8'hFF; // W[8] = cos(16?/32) = -1.0
parameter signed [7:0] tw_im8  = 8'h00; // W[8] = sin(16?/32) = 0.0

parameter signed [7:0] tw_re9  = 8'h80; // W[9] = cos(18?/32) = -0.9239
parameter signed [7:0] tw_im9  = 8'h7F; // W[9] = sin(18?/32) = -0.3827

parameter signed [7:0] tw_re10 = 8'h00; // W[10] = cos(20?/32) = -0.7071
parameter signed [7:0] tw_im10 = 8'hFF; // W[10] = sin(20?/32) = -0.7071

parameter signed [7:0] tw_re11 = 8'h80; // W[11] = cos(22?/32) = -0.3827
parameter signed [7:0] tw_im11 = 8'h80; // W[11] = sin(22?/32) = -0.9239

parameter signed [7:0] tw_re12 = 8'h00; // W[12] = cos(24?/32) = 0.0
parameter signed [7:0] tw_im12 = 8'h80; // W[12] = sin(24?/32) = -1.0

parameter signed [7:0] tw_re13 = 8'h80; // W[13] = cos(26?/32) = 0.3827
parameter signed [7:0] tw_im13 = 8'h80; // W[13] = sin(26?/32) = -0.9239

parameter signed [7:0] tw_re14 = 8'h00; // W[14] = cos(28?/32) = 0.7071
parameter signed [7:0] tw_im14 = 8'h80; // W[14] = sin(28?/32) = -0.7071

parameter signed [7:0] tw_re15 = 8'h7F; // W[15] = cos(30?/32) = 0.9239
parameter signed [7:0] tw_im15 = 8'h80; // W[15] = sin(30?/32) = -0.3827

//STAGE 1 OF DIF FFT
// Intermediate results for butterflies
assign dr0  = r0 + r16;   assign di0  = i0 + i16;
assign dr16 = (r0 - r16) * tw_re0 - (i0 - i16) * tw_im0;
assign di16 = (i0 - i16) * tw_re0 + (r0 - r16) * tw_im0;

assign dr1  = r1 + r17;   assign di1  = i1 + i17;
assign dr17 = (r1 - r17) * tw_re1 - (i1 - i17) * tw_im1;
assign di17 = (i1 - i17) * tw_re1 + (r1 - r17) * tw_im1;

assign dr2  = r2 + r18;   assign di2  = i2 + i18;
assign dr18 = (r2 - r18) * tw_re2 - (i2 - i18) * tw_im2;
assign di18 = (i2 - i18) * tw_re2 + (r2 - r18) * tw_im2;

assign dr3  = r3 + r19;   assign di3  = i3 + i19;
assign dr19 = (r3 - r19) * tw_re3 - (i3 - i19) * tw_im3;
assign di19 = (i3 - i19) * tw_re3 + (r3 - r19) * tw_im3;

assign dr4  = r4 + r20;   assign di4  = i4 + i20;
assign dr20 = (r4 - r20) * tw_re4 - (i4 - i20) * tw_im4;
assign di20 = (i4 - i20) * tw_re4 + (r4 - r20) * tw_im4;

assign dr5  = r5 + r21;   assign di5  = i5 + i21;
assign dr21 = (r5 - r21) * tw_re5 - (i5 - i21) * tw_im5;
assign di21 = (i5 - i21) * tw_re5 + (r5 - r21) * tw_im5;

assign dr6  = r6 + r22;   assign di6  = i6 + i22;
assign dr22 = (r6 - r22) * tw_re6 - (i6 - i22) * tw_im6;
assign di22 = (i6 - i22) * tw_re6 + (r6 - r22) * tw_im6;

assign dr7  = r7 + r23;   assign di7  = i7 + i23;
assign dr23 = (r7 - r23) * tw_re7 - (i7 - i23) * tw_im7;
assign di23 = (i7 - i23) * tw_re7 + (r7 - r23) * tw_im7;

assign dr8  = r8 + r24;   assign di8  = i8 + i24;
assign dr24 = (r8 - r24) * tw_re8 - (i8 - i24) * tw_im8;
assign di24 = (i8 - i24) * tw_re8 + (r8 - r24) * tw_im8;

assign dr9  = r9 + r25;   assign di9  = i9 + i25;
assign dr25 = (r9 - r25) * tw_re9 - (i9 - i25) * tw_im9;
assign di25 = (i9 - i25) * tw_re9 + (r9 - r25) * tw_im9;

assign dr10 = r10 + r26;  assign di10 = i10 + i26;
assign dr26 = (r10 - r26) * tw_re10 - (i10 - i26) * tw_im10;
assign di26 = (i10 - i26) * tw_re10 + (r10 - r26) * tw_im10;

assign dr11 = r11 + r27;  assign di11 = i11 + i27;
assign dr27 = (r11 - r27) * tw_re11 - (i11 - i27) * tw_im11;
assign di27 = (i11 - i27) * tw_re11 + (r11 - r27) * tw_im11;

assign dr12 = r12 + r28;  assign di12 = i12 + i28;
assign dr28 = (r12 - r28) * tw_re12 - (i12 - i28) * tw_im12;
assign di28 = (i12 - i28) * tw_re12 + (r12 - r28) * tw_im12;

assign dr13 = r13 + r29;  assign di13 = i13 + i29;
assign dr29 = (r13 - r29) * tw_re13 - (i13 - i29) * tw_im13;
assign di29 = (i13 - i29) * tw_re13 + (r13 - r29) * tw_im13;

assign dr14 = r14 + r30;  assign di14 = i14 + i30;
assign dr30 = (r14 - r30) * tw_re14 - (i14 - i30) * tw_im14;
assign di30 = (i14 - i30) * tw_re14 + (r14 - r30) * tw_im14;

assign dr15 = r15 + r31;  assign di15 = i15 + i31;
assign dr31 = (r15 - r31) * tw_re15 - (i15 - i31) * tw_im15;
assign di31 = (i15 - i31) * tw_re15 + (r15 - r31) * tw_im15;

fft16 instance1 (
.clk(clk),
    .r0(dr0), .r1(dr1), .r2(dr2), .r3(dr3), .r4(dr4), .r5(dr5), .r6(dr6), .r7(dr7),
    .r8(dr8), .r9(dr9), .r10(dr10), .r11(dr11), .r12(dr12), .r13(dr13), .r14(dr14), .r15(dr15),
    .i0(di0), .i1(di1), .i2(di2), .i3(di3), .i4(di4), .i5(di5), .i6(di6), .i7(di7),
    .i8(di8), .i9(di9), .i10(di10), .i11(di11), .i12(di12), .i13(di13), .i14(di14), .i15(di15),
   .R0(R0), .R1(R16), .R2(R8), .R3(R24), .R4(R4), .R5(R20), .R6(R12), .R7(R28),
    .R8(R2), .R9(R18), .R10(R10), .R11(R26), .R12(R6), .R13(R22), .R14(R14), .R15(R30),
    .I0(I0), .I1(I16), .I2(I8), .I3(I24), .I4(I4), .I5(I20), .I6(I12), .I7(I28),
    .I8(I2), .I9(I18), .I10(I10), .I11(I26), .I12(I6), .I13(I22), .I14(I14), .I15(I30)
);

fft16 instance2 ( 
    .clk(clk),
    .r0(dr16), .r1(dr17), .r2(dr18), .r3(dr19), .r4(dr20), .r5(dr21), .r6(dr22), .r7(dr23),
    .r8(dr24), .r9(dr25), .r10(dr26), .r11(dr27), .r12(dr28), .r13(dr29), .r14(dr30), .r15(dr31),
    .i0(di16), .i1(di17), .i2(di18), .i3(di19), .i4(di20), .i5(di21), .i6(di22), .i7(di23),
    .i8(di24), .i9(di25), .i10(di26), .i11(di27), .i12(di28), .i13(di29), .i14(di30), .i15(di31),
    .R0(R1), .R1(R17), .R2(R9), .R3(R25), .R4(R5), .R5(R21), .R6(R13), .R7(R29),
    .R8(R3), .R9(R19), .R10(R11), .R11(R27), .R12(R7), .R13(R23), .R14(R15), .R15(R31),
    .I0(I1), .I1(I17), .I2(I9), .I3(I25), .I4(I5), .I5(I21), .I6(I13), .I7(I29),
    .I8(I3), .I9(I19), .I10(I11), .I11(I27), .I12(I7), .I13(I23), .I14(I15), .I15(I31)

);

/*FFTeight instance3 (
    .clk(clk),
    .r0(cr0), .r1(cr1), .r2(cr2), .r3(cr3), .r4(cr4), .r5(cr5), .r6(cr6), .r7(cr7),
    .i0(ci0), .i1(ci1), .i2(ci2), .i3(ci3), .i4(ci4), .i5(ci5), .i6(ci6), .i7(ci7),
    .R0(R0), .R1(R8), .R2(R4), .R3(R12), .R4(R2), .R5(R10), .R6(R6), .R7(R14),
    .I0(I0), .I1(I8), .I2(I4), .I3(I12), .I4(I2), .I5(I10), .I6(I6), .I7(I14)
);

FFTeight instance4 (
    .clk(clk),
    .r0(cr8), .r1(cr9), .r2(cr10), .r3(cr11), .r4(cr12), .r5(cr13), .r6(cr14), .r7(cr15),
    .i0(ci8), .i1(ci9), .i2(ci10), .i3(ci11), .i4(ci12), .i5(ci13), .i6(ci14), .i7(ci15),
    .R0(R1), .R1(R9), .R2(R5), .R3(R13), .R4(R3), .R5(R11), .R6(R7), .R7(R15),
    .I0(I1), .I1(I9), .I2(I5), .I3(I13), .I4(I2), .I5(I11), .I6(I7), .I7(I15)
);
*/


endmodule