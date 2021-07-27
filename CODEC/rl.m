function nrBits=rl(y)

%Sinal devolve nas posi��es impares os valores que ocorrem
%E nas posi��es pares o n�mero de ocorr�ncias
sinal = rle(y);
impares = 1:2:length(sinal);
pares = 2:2:length(sinal);

%Fazemos o unique que dado propriedades internas depois nos
% vai permitir utilizar utilizar o de2bi
% (Que s� aceita n�s >0 e inteiros)
[~,~,difvalues] = unique(sinal(impares));

%Probabilidades de ocorr�ncia de cada elemento
prob = sinal(pares);

%Onde vamos colocar o numero de bits que precisamos para
%representar cada elemento * (n_vezes que este ocorre)
lenvalores = zeros(1,length(difvalues));

for i=1:length(difvalues)
    lenvalores(i) = length(de2bi(difvalues(i))) * prob(i);
end

nrBits = sum(lenvalores);

end