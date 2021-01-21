function ang = calculate_angles(x1, x2, treshold)
    d=0.04;
    c=343;
    [theta, f] = get_phase_diff_with_frequencies(x1,x2, treshold);
    
    for i = 1:size(theta,2)
        lambda = c/f(i);
        deltaD =theta(i) * lambda/(2*pi);
        sinus = deltaD/d;
        if sinus > 1
            sinus = 1;
        elseif sinus < -1
            sinus = -1;
        end
        ang(i) = rad2deg(asin(sinus));
%         ang(i)=sinus;
    end

end