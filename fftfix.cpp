#include "128fft.h"         // Adjusted to a new header file for 128-point FFT
#include "128fftvalues.h"    // Adjusted to a new header for twiddle factors and bit-reversal

using namespace std;

void bitreverse(data_comp data_IN[N], data_comp data_OUT[N]) { // perform 128-point bit reversal
    bitreversal_label1: for (int i = 0; i < N; i++) {
        int index = rev_128[i]; // Use precomputed 128-point bit reversal array
        data_OUT[i] = data_IN[index];
    }
}

void FFT0(int FFT_stage, int pass_check, int index_shift, int pass_shift, data_comp data_IN[N], data_comp data_OUT[N]) {
    int butterfly_span = 0, butterfly_pass = 0;
    FFT_label1: for (int i = 0; i < N / 2; i++) {
        int index = butterfly_span << index_shift;
        int Ulimit = butterfly_span + (butterfly_pass << pass_shift);
        int Llimit = Ulimit + FFT_stage;
        data_comp Product = W[index] * data_IN[Llimit]; // Calculate the product
        data_OUT[Llimit] = data_IN[Ulimit] - Product;
        data_OUT[Ulimit] = data_IN[Ulimit] + Product;
        
        if (butterfly_span < FFT_stage - 1) {
            butterfly_span++;
        } else if (butterfly_pass < pass_check - 1) {
            butterfly_span = 0;
            butterfly_pass++;
        } else {
            butterfly_span = 0;
            butterfly_pass = 0;
        }
    }
}

void FFT(data_comp data_IN[N], data_comp data_OUT[N]) {
    static data_comp data_OUT0[N];
    static data_comp data_OUT1[N];
    static data_comp data_OUT2[N];
    static data_comp data_OUT3[N];
    static data_comp data_OUT4[N];
    static data_comp data_OUT5[N];
    static data_comp data_OUT6[N];

    bitreverse(data_IN, data_OUT0);  // Calculate bit-reverse order

    FFT0(1, 64, 6, 1, data_OUT0, data_OUT1); // Calculate the FFT stages
    FFT0(2, 32, 5, 2, data_OUT1, data_OUT2);
    FFT0(4, 16, 4, 3, data_OUT2, data_OUT3);
    FFT0(8, 8, 3, 4, data_OUT3, data_OUT4);
    FFT0(16, 4, 2, 5, data_OUT4, data_OUT5);
    FFT0(32, 2, 1, 6, data_OUT5, data_OUT6);
    FFT0(64, 1, 0, 7, data_OUT6, data_OUT);
}
