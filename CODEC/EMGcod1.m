close all
clear all

warning('off', 'all');

%Step1 : Read Data from .csv tile
Fs = 250; %sampling frequency
sinal_original = csvread('EMG_norm.csv');
audiowrite('EMG_norm.wav', sinal_original, 16);
[sinal_original, ~] = audioread('EMG_norm.wav');

%sinal original
freq_original = contar_ocorrencias(unique(sinal_original), sinal_original);
entropia_origin = entropia(freq_original);
len_original = numel(sinal_original)*16;

figure;
subplot(3,1,1);
plot(sinal_original);
xlabel('Time/s','fontsize', 8); 
ylabel('Signal magnitude', 'fontsize', 8); 
title('Original EMG signal', 'fontsize', 10);

fprintf("Entropia original: %.3f\n", entropia_origin);
fprintf("Sem Preditores:\n");
fprintf("Sinal Original : %d\n", len_original);

%%
%Predictors

%Preditor Linear Prediction Filter Coefficient(LPC)
[entropialpc, e] = linearP(sinal_original, 1, 10);
entropia_lpc = entropialpc;
subplot(3, 1, 2);
plot(e);
xlabel('Time/s','fontsize', 8); 
ylabel('Signal magnitude', 'fontsize', 8); 
title('LPC EMG signal', 'fontsize', 10);

%codificadores entrópicos

%huffman
[~,len_huffman] = huffman(contar_ocorrencias(unique(e), e)/length(e),length(e));
%golomb
len_golomb = lenGolomb(e);
%arithmeticEncoding
len_arith = length(arithmeticEncoding(e));
%run length 
len_rle= rl(e);

fprintf("\nEntropia_LPC: %.3f\n", entropia_lpc);
fprintf("Preditor: LPC | Huffman: %d, Golomb Rice: %d, Aritmético: %d, Run Length: %d\n", len_huffman, len_golomb, len_arith, len_rle);
fprintf("Compression Rate:\nCR huff: %.3f, CR golomb: %.3f, CR arith: %.3f, CR rle: %.3f\n", len_original/len_huffman, len_original/len_golomb, len_original/len_arith, len_original/len_rle);
fprintf("Compression Ratio:\nHuffman: %3.f, Golomb: %.3f, Arith: %.3f, RLE: %.3f\n", 100 - (len_huffman/len_original)*100, 100 - (len_golomb/len_original)*100, 100 - (len_arith/len_original)*100, 100 - (len_rle/len_original)*100);


%%
% delta primeira ordem (xprev(k) = x(k-1))
array = zeros(size(sinal_original));
array(1) = 0;
array(2:end)= sinal_original(1:end-1);
erro = sinal_original - array;
figure;
plot(erro);

audiowrite('errodelta.wav', erro, 250, 'BitsPerSample', 16);
[erro, ~] = audioread('errodelta.wav');

%entropia depois do preditor
conta3= contar_ocorrencias(unique(erro), erro);
entropia_3 = entropia(conta3);

%codificadores entrópicos
[~,len_huffman] = huffman(contar_ocorrencias(unique(erro), erro)/length(erro),length(erro));
len_golomb = lenGolomb(erro);
len_arith = length(arithmeticEncoding(erro));
len_rle= rl(erro);

cr_huff= (length(sinal_original)*16)/len_huffman;
cr_golomb = (length(sinal_original)*16)/len_golomb;
cr_arith = (length(sinal_original)*16)/len_arith;
cr_rle = (length(sinal_original)*16)/len_rle;

fprintf("\nEntropia_delta: %.3f\n", entropia_3);
fprintf("Preditor: Delta | Huffman: %d, Golomb Rice: %d, Aritmético: %d, Run Length: %d\n", len_huffman, len_golomb, len_arith, len_rle);
fprintf("Compression Rate:\nCR huff: %.3f, CR golomb: %.3f, CR arith: %.3f, CR rle: %.3f\n", len_original/len_huffman, len_original/len_golomb, len_original/len_arith, len_original/len_rle);
fprintf("Compression Ratio:\nHuffman: %3.f, Golomb: %.3f, Arith: %.3f, RLE: %.3f\n", 100 - (len_huffman/len_original)*100, 100 - (len_golomb/len_original)*100, 100 - (len_arith/len_original)*100, 100 - (len_rle/len_original)*100);

































