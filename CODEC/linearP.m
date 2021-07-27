
function [m, erro] = linearPC(y,ordem,window)
    
    medio = [];
    erro = zeros(1,length(y));
    for i=1:window:length(y)-window+1
        janela = y(i:i+window-1,1);
        a = lpc(janela,min([ordem window]));
        f = filter(-a(2:end),1,janela);
        
        erro(1,i:i+window-1) = janela-f;
        medio(1,((i-1)/window)+1) = (1/window)*sum(erro.*erro);
      
    end
    
    if(mod(length(y),window)~=0)
        i = i+window;
        janela = y(i:length(y), 1);

        a = lpc(janela,ordem);
        f = filter(-a(2:end),1,janela);
        erro(1,i:length(y)) = janela -f;
        medio(1,((i-1)/window)+1) = (1/mod(length(y),window))*sum(erro.*erro); 
    end
    
    m = sum(medio)/length(medio);
    audiowrite("errolpc.wav", erro, 250, 'BitsPerSample', 16);
    erro = audioread("errolpc.wav");  
    
end

