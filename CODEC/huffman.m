function [huff, lenHuff] = huffman(prob, lenSignal)
    
    hl = hufflen(prob);
    hl = hl.*prob;
    huff = sum(hl);
    
    if nargin == 2
        contador = prob.*lenSignal;
        hl = hufflen(prob);
        lenHuff = contador.*hl;
        lenHuff = sum(lenHuff);
    end
end