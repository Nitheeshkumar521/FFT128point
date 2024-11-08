#ifndef FFT128_H
#define FFT128_H

#include <complex>
#include <cmath>

const int N = 128;  // FFT size, set to 128 for a 128-point FFT

// Define a complex data type
using data_comp = std::complex<float>;

// Function prototypes
void bitreverse(data_comp data_IN[N], data_comp data_OUT[N]);
void FFT0(int FFT_stage, int pass_check, int index_shift, int pass_shift, data_comp data_IN[N], data_comp data_OUT[N]);
void FFT(data_comp data_IN[N], data_comp data_OUT[N]);

#endif // FFT128_H
