treshold = 0.02;
first = load('No_echo_#2_60deg.mat').audio_data;
second = load('No_echo_#7_150deg.mat').audio_data;
sizeFirst = size(first,1);
sizeSecond = size(second,1);
if sizeFirst > sizeSecond
    first = first(1:sizeSecond,:);
elseif sizeSecond > sizeFirst
    second = second(1:sizeFirst,:); 
end
merged = (first + second)/2;
x1 = first(:,1);
x2 = first(:,2);
x3 = first(:,3);

% x1 = merged(:,1);
% x2 = merged(:,2);
% x3 = merged(:,3);
suma12 = [];
suma23 = [];
suma31 = [];
window_size = 256;
window_no = floor(size(x1,1)/window_size);

for i = 1:window_no
    results12 = calculate_angles(x1((i-1)*window_size +1 :window_size*i),x2((i-1)*window_size +1 :window_size*i), treshold);
    suma12 = [suma12 results12];
end
figure;
histogram(suma12,100);
title("1 - 2");

for i = 1:window_no
    results23 = calculate_angles(x2((i-1)*window_size +1 :window_size*i),x3((i-1)*window_size +1 :window_size*i), treshold);
    suma23 = [suma23 results23];
end
figure;
histogram(suma23,100);
title("2 - 3");

for i = 1:window_no
    results31 = calculate_angles(x3((i-1)*window_size +1 :window_size*i),x1((i-1)*window_size +1 :window_size*i), treshold);
    suma31 = [suma31 results31];
end
figure;
histogram(suma31,100);
title("3 - 1");
