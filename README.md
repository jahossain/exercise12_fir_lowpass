# exercise12_fir_lowpass

![image](https://github.com/jahossain/exercise12_fir_lowpass/blob/main/image/Screenshot%202025-10-29%20205430.png)


## Explanation
When the filter order **M** increases from 20 to 64, the **transition band** between the passband and stopband becomes much **narrower**, resulting in a sharper cutoff.  
The **impulse response** also becomes **longer**, because a higher-order FIR filter requires more coefficients to achieve the desired frequency characteristics.  
As M increases, the filter’s approximation of the ideal low-pass shape improves, producing a **smoother** and **sharper** frequency response with reduced leakage between bands.  
However, the higher order also means **greater computational cost** and **longer delay**, since the filter length directly affects the number of multiplications per output sample.


**MATLAB Version:** R2023b  
**Author:** [Md Hossain]  
**Date:** [29.10.2025]
