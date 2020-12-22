
x1 = audio_data(:,1);
x2 = audio_data(:,2);
x3 = audio_data(:,3);

result12 = calculate_angle(x1,x2);
result23 = calculate_angle(x2,x3);
result31 = calculate_angle(x3,x1);