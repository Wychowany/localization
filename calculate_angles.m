function ang = calculate_angles(x1, x2, treshold)
% function calcuating angles from which signal came
    % distance beetwen microphones
    d=0.04;
    % speed of sound m/s
    c=343;
    ang=[];
    % phase difference
    [theta, f] = get_phase_diff_with_frequencies(x1,x2, treshold);
    for i = 1:size(theta,2)
        % calcualting delta D 
        lambda = c/f(i);
        deltaD =theta(i) * lambda/(2*pi);
        sinus = deltaD/d;
        if sinus > 1
            sinus = 1;
        elseif sinus < -1
            sinus = -1;
        end
        % arcsinus + conversion to degrees
        ang(i) = rad2deg(asin(sinus));
        
    end
end