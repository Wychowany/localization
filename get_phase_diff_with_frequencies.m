function [PhDiff,base] = get_phase_diff_with_frequencies(x, y, treshold)
% function calcualting phase difference using fft
% phase difference
PhDiff=[];
% frequency for chosen phases
base=[];

x = x(:);
y = y(:);
% sampling rate
fs = 8000;
X = fft(x);
Y = fft(y);
N = size(Y,1);
Ay = abs(Y);
Ax = abs(X);
Ay = Ay/N;
Ax = Ax/N;
Ay = Ay(1:floor(N/2+1));
Ax = Ax(1:floor(N/2+1));
Ay(2:end-1) = 2*Ay(2:end-1);
Ax(2:end-1) = 2*Ax(2:end-1);
f_step = fs/N;     % frequency step per one sample
f = 0:f_step:fs/2; % frequency scale for the plot
% plot(Ax);
j=1;
for i = 1:size(f,2)
    % if signal is not noise
    if Ax(i) > treshold
        base(j) = fs/N * i; % frequency
        PhDiff(j) = angle(Y(i)) - angle(X(i));
        j = j + 1;
    end
end
end