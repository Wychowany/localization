function [PhDiff,base] = phdiffmeasure(x, y)
x = x(:);
y = y(:);

X = fft(x); 
Y = fft(y);

[~, indx] = max(abs(X));
[~, indy] = max(abs(Y));

PhDiff = angle(Y(indy)) - angle(X(indx));
base = X(indx);
end