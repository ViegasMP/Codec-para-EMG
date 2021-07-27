function [contar] = contar_ocorrencias(alfabeto, fonte)
%Conta as ocorrências do alfabeto na fonte
%Devolve uma matriz com a contagem

    contar = zeros(length(alfabeto),1);

    for l=1:length(alfabeto)
        i = find(fonte==alfabeto(l));
        contar(l)=length(i);
    end
%output= contar;

end

