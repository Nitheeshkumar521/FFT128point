#include <iostream>
#include <iomanip>
#include "128fft.h"
#include "128fftvalues.h"

using namespace std;

void print_output(const data_comp data_OUT[N]) {
    cout << fixed << setprecision(4);
    for (int i = 0; i < N; i++) {
        cout << "Index " << i << ": ";
        cout << "Real: " << data_OUT[i].real() << ", Imaginary: " << data_OUT[i].imag() << endl;
    }
}

int main() {
    // Initialize input data
    data_comp data_IN[N];
    data_comp data_OUT[N];

    // Example input signal: can be replaced with actual data
    for (int i = 0; i < N; i++) {
        data_IN[i] = data_comp(sin(2 * M_PI * i / N), 0);  // Simple sinusoidal input signal
    }

    // Perform FFT
    FFT(data_IN, data_OUT);

    // Display output
    cout << "FFT Output:" << endl;
    print_output(data_OUT);

    return 0;
}
