function [code] = arithmeticEncoding(array)

    [~,~,array] = unique(array); 
    %conta quantas vezes um elemento aparece num array com base no alfabeto
    contador = accumarray(array, 1); 
    
    code = arithenco(array, contador);

end