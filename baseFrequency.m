function F0 = baseFrequency(x, fs)
    N=size(x, 1);
    Y = fft(x);     % Fourier transform

    A = abs(Y);     % signal amplitude
    A = A/N;        % amplitude normalization
    A = A(1:N/2+1); % truncation of the negative frequency terms
    A(2:end-1) = 2*A(2:end-1);

    f_step = fs/N;     % frequency step per one sample
    f = 0:f_step:fs/2; % frequency scale for the plot

    plot(f, A);     % plot the amplitude spectrum
    F0=0;
end