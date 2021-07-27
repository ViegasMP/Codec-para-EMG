function [H] = entropia(contagem)

%limite mínimo teórico para o número médio de bits por símbolo

H = 0;
%Fórmula da Entropia:
%H = somatorio *  (probabilidade(ai)*log2(1/prob(ai)) )
%  = - somatorio * (probabilidade(ai)*log2(prob(ai))
  
    total=sum(contagem);
    probabilidade= contagem/total;
    probabilidade= probabilidade(probabilidade~=0); %elimina probabilidades = 0 (~= 0 significa diferentes de 0)
    H = -sum(probabilidade.*log2(probabilidade));
    
    %output= H;

end

