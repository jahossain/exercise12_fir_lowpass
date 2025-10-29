% ---------------------------------------------------------
% Exercise 12 - FIR Low Pass Filter using MATLAB
% ---------------------------------------------------------

clear; clc;

% ---- Parameters ----
fc      = 0.25;           
M_values = [20 64];       
Nfft    = 1024;           
outdir  = 'figures';

% ---- Ensure output folder exists ----
if ~isfolder(outdir)
    mkdir(outdir);
end

fprintf('Saving figures to: %s\n', fullfile(pwd, outdir));

for M = M_values
    try
        n  = 0:M;
        wc = pi*fc;

        % ---- Impulse response h_LP(n) ----
        h_LP = sin(wc*(n - M/2)) ./ (pi*(n - M/2));
        h_LP(n == M/2) = wc/pi;   

        % ---- Frequency response ----
        H_LP = fft(h_LP, Nfft);
        w    = linspace(-pi, pi, Nfft);

        % ---- Plot & save: impulse response ----
        f1 = figure('Name', sprintf('Impulse M=%d', M), 'NumberTitle','off');
        stem(n, h_LP, 'filled'); grid on;
        title(sprintf('Impulse Response h_{LP}(n) for M = %d', M));
        xlabel('n'); ylabel('h_{LP}(n)');
        fn_imp = fullfile(outdir, sprintf('h_LP_M%d.png', M));
        saveas(f1, fn_imp);
        fprintf('✔ Saved: %s\n', fn_imp);

        % ---- Plot & save: magnitude response ----
        f2 = figure('Name', sprintf('Magnitude M=%d', M), 'NumberTitle','off');
        plot(w/pi, abs(fftshift(H_LP)), 'LineWidth', 1.5); grid on;
        title(sprintf('|H_{LP}(e^{j\\omega})| for M = %d', M));
        xlabel('Normalized Frequency (×\pi rad/sample)'); ylabel('Magnitude');
        fn_mag = fullfile(outdir, sprintf('h_LP_Mag_M%d.png', M));
        saveas(f2, fn_mag);
        fprintf('✔ Saved: %s\n', fn_mag);

        if exist(fn_imp,'file')~=2, warning('Did not find %s after save.', fn_imp); end
        if exist(fn_mag,'file')~=2, warning('Did not find %s after save.', fn_mag); end

        drawnow; pause(0.5);

    catch ME
        warning('Failed while processing M=%d: %s', M, ME.message);
    end
end

% ---- Comparison plot (M=20 vs M=64) ----
f3 = figure('Name','Comparison','NumberTitle','off'); hold on;
for M = M_values
    n  = 0:M;
    wc = pi*fc;
    h  = sin(wc*(n - M/2))./(pi*(n - M/2));
    h(n == M/2) = wc/pi;
    H  = fft(h, Nfft);
    w  = linspace(-pi, pi, Nfft);
    plot(w/pi, abs(fftshift(H)), 'LineWidth', 1.5, 'DisplayName', sprintf('M = %d', M));
end
grid on; legend('show');
title('Comparison of Magnitude Responses (M = 20 vs 64)');
xlabel('Normalized Frequency (×\pi rad/sample)'); ylabel('Magnitude');

fn_cmp = fullfile(outdir, 'h_LP_compare.png');
saveas(f3, fn_cmp);
fprintf('✔ Saved: %s\n', fn_cmp);

drawnow; pause(0.5);

fprintf('\nDone. Open these if needed:\n  %s\n  %s\n  %s\n', ...
    fullfile(outdir,'h_LP_M20.png'), fullfile(outdir,'h_LP_M64.png'), fn_cmp);
