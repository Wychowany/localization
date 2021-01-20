% treshold = 0.0015;
treshold = 0;
first = load('No_echo_#2_60deg.mat').audio_data;
second = load('No_echo_#7_120deg.mat').audio_data;
sizeFirst = size(first,1);
sizeSecond = size(second,1);

if sizeFirst > sizeSecond
    first = first(1:sizeSecond,:);
elseif sizeSecond > sizeFirst
    second = second(1:sizeFirst,:); 
end

merged = (first + second)/2;
% x1 = first(:,1);
% x2 = first(:,2);
% x3 = first(:,3);

% x1 = second(:,1);
% x2 = second(:,2);
% x3 = second(:,3);

x1 = merged(:,1);
x2 = merged(:,2);
x3 = merged(:,3);
window_size = 256;
no_windows = floor(size(x1,1)/window_size);
suma = [];
% sound(x1)
figure;
for i=1:no_windows
    
    results12 = calculate_angles(x3( (i-1)*window_size+1 : window_size*i ),x2((i-1)*window_size+1 : window_size*i), treshold);
    suma = [suma results12];
end
histogram(suma,1000);

% figure;
% result23 = calculate_angles(x2,x3, treshold);
% histogram(result23,100);
% figure;
% result31 = calculate_angles(x3,x1, treshold);
% histogram(result31,100);