function [lengthGolomb] = lenGolomb(array)
    
    [~,~,array] = unique(array);

    %picking our m for the golomb
    m = 2^floor(log2(mean(array)));
    
    %total num of bits
    lengthGolomb = 0;
    
    for i=1:numel(array)
        lengthGolomb = lengthGolomb+length(golomb_enco(array(i), m));
    end
end