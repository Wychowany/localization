treshold = 0.0015;
first = load('No_echo_#2_60deg.mat').audio_data;
second = load('No_echo_#7_240deg.mat').audio_data;
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

results12 = calculate_angles(x1,x2, treshold);
histogram(results12,100);

% result23 = calculate_angles(x2,x3);
% result31 = calculate_angles(x3,x1);