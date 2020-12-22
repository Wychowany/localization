function ang = calculate_angle(x1, x2)
d=0.04;
c=343;
F0 = 175;
[theta, base] = phdiffmeasure(x1,x2);
lambda = c/F0;
deltaD =theta * lambda/(2*pi);
sinus = deltaD/d;
ang = rad2deg(angle(asin(sinus)));
end