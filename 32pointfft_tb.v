32 pttb

`timescale 1ns / 1ps

module tb_fft32pt_stage1;

    // Clock and input signals
    reg clk;
    reg signed [1:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
    reg signed [1:0] r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
    reg signed [1:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15;
    reg signed [1:0] i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31;

    // Outputs
    wire signed [13:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
    wire signed [13:0] R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31;
    wire signed [13:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
    wire signed [13:0] I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31;

    // Instantiate the FFT module
    fft32pt_stage1 uut (
        .clk(clk),
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9),
        .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r16(r16), .r17(r17),
        .r18(r18), .r19(r19), .r20(r20), .r21(r21), .r22(r22), .r23(r23), .r24(r24), .r25(r25),
        .r26(r26), .r27(r27), .r28(r28), .r29(r29), .r30(r30), .r31(r31),
        .i0(i0), .i1(i1), .i2(i2), .i3(i3), .i4(i4), .i5(i5), .i6(i6), .i7(i7), .i8(i8), .i9(i9),
        .i10(i10), .i11(i11), .i12(i12), .i13(i13), .i14(i14), .i15(i15), .i16(i16), .i17(i17),
        .i18(i18), .i19(i19), .i20(i20), .i21(i21), .i22(i22), .i23(i23), .i24(i24), .i25(i25),
        .i26(i26), .i27(i27), .i28(i28), .i29(i29), .i30(i30), .i31(i31),
        .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9),
        .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14), .R15(R15), .R16(R16), .R17(R17),
        .R18(R18), .R19(R19), .R20(R20), .R21(R21), .R22(R22), .R23(R23), .R24(R24), .R25(R25),
        .R26(R26), .R27(R27), .R28(R28), .R29(R29), .R30(R30), .R31(R31),
        .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .I8(I8), .I9(I9),
        .I10(I10), .I11(I11), .I12(I12), .I13(I13), .I14(I14), .I15(I15), .I16(I16), .I17(I17),
        .I18(I18), .I19(I19), .I20(I20), .I21(I21), .I22(I22), .I23(I23), .I24(I24), .I25(I25),
        .I26(I26), .I27(I27), .I28(I28), .I29(I29), .I30(I30), .I31(I31)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        // Initialize inputs
        r0 = 2'd1;   i0 = 2'd0;
        r1 = 2'd1;   i1 = 2'd0;
        r2 = 2'd1;   i2 = 2'd0;
        r3 = 2'd1;   i3 = 2'd0;
        r4 = 2'd1;   i4 = 2'd0;
        r5 = 2'd1;   i5 = 2'd0;
        r6 = 2'd1;   i6 = 2'd0;
        r7 = 2'd1;   i7 = 2'd0;
        r8 = 2'd1;   i8 = 2'd0;
        r9 = 2'd1;   i9 = 2'd0;
        r10 = 2'd1;  i10 = 2'd0;
        r11 = 2'd1;  i11 = 2'd0;
        r12 = 2'd1;  i12 = 2'd0;
        r13 = 2'd1;  i13 = 2'd0;
        r14 = 2'd1;  i14 = 2'd0;
        r15 = 2'd1;  i15 = 2'd0;
        r16 = 2'd0;  i16 = 2'd1;
        r17 = 2'd0;  i17 = 2'd1;
        r18 = 2'd0;  i18 = 2'd1;
        r19 = 2'd0;  i19 = 2'd1;
        r20 = 2'd0;  i20 = 2'd1;
        r21 = 2'd0;  i21 = 2'd1;
        r22 = 2'd0;  i22 = 2'd1;
        r23 = 2'd0;  i23 = 2'd1;
        r24 = 2'd0;  i24 = 2'd1;
        r25 = 2'd0;  i25 = 2'd1;
        r26 = 2'd0;  i26 = 2'd1;
        r27 = 2'd0;  i27 = 2'd1;
        r28 = 2'd0;  i28 = 2'd1;
        r29 = 2'd0;  i29 = 2'd1;
        r30 = 2'd0;  i30 = 2'd1;
        r31 = 2'd0;  i31 = 2'd1;


        // Wait for the outputs to stabilize
        #2000000;

        // Display outputs
        $display("R0: %d, I0: %d", R0, I0);
        // Repeat for all R and I outputs up to R31, I31

        // Finish simulation
        $finish;
    end

endmodule