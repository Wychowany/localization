function [PhDiff,base] = get_phase_diff_with_frequencies(x, y, treshold)
    x = x(:);
    y = y(:);
    fs = 8000;        
    window = hamming(512, 'periodic');
    overlap = 10;

    [S1] = stft(x, fs, 'Window', window, 'OverlapLength', overlap);
    [S2] = stft(y, fs, 'Window', window, 'OverlapLength', overlap);
    magnitude1 = abs(S1);
    for i = 1:size(magnitude1,2)
        [~,maxind] = max(magnitude1(:,i));
        base(i) = maxind;
        phase1(i) = angle(S1(maxind,i));
    end
    magnitude2 = abs(S2);
    for i = 1:size(magnitude1,2)
        [~,maxind] = max(magnitude2(:,i));
        phase2(i) = angle(S2(maxind,i));
    end
    
    PhDiff = phase2 - phase1;

end