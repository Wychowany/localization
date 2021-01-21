function [PhDiff,base] = get_phase_diff_with_frequencies(x, y, treshold)
    x = x(:);
    y = y(:);
    fs = 8000; 
    window_size = 256;
    window = hamming(window_size, 'periodic');
    overlap = 100;

    [S1,F] = stft(x, fs, 'Window', window, 'OverlapLength', overlap);
    [S2] = stft(y, fs, 'Window', window, 'OverlapLength', overlap);
    
    N = size(F,1);
    magnitude1 = abs(S1);
    magnitude2 = abs(S2);
        k=1;
    for i = 1:size(S1,1)
        for j = 1:size(S1,2)
% 
%             [~,maxind] = max(magnitude1(:,i));
%             phase1= angle(S1(maxind,i));
% 
%             [~,maxind] = max(magnitude2(:,i));
%             phase2 = angle(S2(maxind,i));
% 
%             PhDiff(i) = phase2 - phase1;
%             base(i) =  F(i) * fs/N;
            if (magnitude1(i,j) > treshold && magnitude2(i,j)>treshold)
                PhDiff(k) = angle(S2(i,j))-angle(S1(i,j));
                base(k) = (j/N) * fs ;
                k = k+1;
            end
        end
    end
end