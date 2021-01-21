close all;
% threshold for noise cancellation
treshold = 0.02;
% file read
first = load('No_echo_#2_300deg.mat').audio_data;
second = load('No_echo_#7_30deg.mat').audio_data;
sizeFirst = size(first,1);
sizeSecond = size(second,1);

if sizeFirst > sizeSecond
    first = first(1:sizeSecond,:);
elseif sizeSecond > sizeFirst
    second = second(1:sizeFirst,:); 
end
% source 
% x1 = first(:,1);
% x2 = first(:,2);
% x3 = first(:,3);

% x1 = second(:,1);
% x2 = second(:,2);
% x3 = second(:,3);

% merging signals
merged = (first + second)/2;
x1 = merged(:,1);
x2 = merged(:,2);
x3 = merged(:,3);

suma12 = [];
suma23 = [];
suma31 = [];
% window size
window_size = 512;
window_no = floor(size(x1,1)/window_size);

% degrees for every microphone pair
% windowed fft
for i = 1:window_no
    results12 = calculate_angles(x1((i-1)*window_size +1 :window_size*i),x2((i-1)*window_size +1 :window_size*i), treshold);
    suma12 = [suma12 results12];
end
% figure;
% histogram(suma12,100);
% title("1 - 2");

for i = 1:window_no
    results23 = calculate_angles(x2((i-1)*window_size +1 :window_size*i),x3((i-1)*window_size +1 :window_size*i), treshold);
    suma23 = [suma23 results23];
end
% figure;
% histogram(suma23,100);
% title("2 - 3");

for i = 1:window_no
    results31 = calculate_angles(x3((i-1)*window_size +1 :window_size*i),x1((i-1)*window_size +1 :window_size*i), treshold);
    suma31 = [suma31 results31];
end
% figure;
% histogram(suma31,100);
% title("3 - 1");

% symmetrical pairs
for i=1:size(suma12,2)
    if suma12(i)>0
        suma21(i) = 180 - suma12(i);
    else
        suma21(i)= -180 - suma12(i);
    end
end
for i=1:size(suma23,2)
    if suma23(i)>0
        suma32(i) = 180 - suma23(i);
    else
        suma32(i)= -180 - suma23(i);
    end
end
for i=1:size(suma31,2)
    if suma31(i)>0
        suma13(i) = 180 - suma31(i);
    else
        suma13(i)= -180 - suma31(i);
    end
end

% scaling
suma12 = round(suma12 + 60,-1);
suma23 = round(suma23 + 180,-1);
suma31 = round(suma31 - 60,-1);

suma21 = round(suma21 + 60,-1);
suma32 = round(suma32 + 180,-1);
suma13 = round(suma13 - 60,-1);

suma = [suma21 suma12 suma23 suma32 suma31 suma13];

suma = suma+210;
for i = 1: size(suma,2)
    if suma(i)>360
        suma(i) = suma(i)-360;
    end
end

% Histogram of found degrees
figure;
H = histogram(suma,180,'BinLimits',[0 360]);
title("Kąt globalny");

% 1st found degree
temp = H.Values;
[~,degree] = max(temp);
temp(degree) = 0;
degree = H.BinEdges(degree);
disp(degree);

% 2nd found degree - only when 2 sources of sound
[~,degree2] = max(temp);
temp(degree2) = 0;
degree2 = H.BinEdges(degree2);
disp(degree2);