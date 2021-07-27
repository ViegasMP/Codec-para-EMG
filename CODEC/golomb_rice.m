function v = golomb_rice(fonte)
    fonte=trataSom(fonte);
    v=zeros(1,length(fonte));
    v=string(v);
    s=zeros(length(fonte),16);
    for i=1:length(fonte)
        s(i,:)=decimalToBinaryVector(fonte(i),16);
    end
    for i=1:length(fonte)
        temp1=mask(s(i,:),[1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0]);
        temp2=mask(s(i,:),[0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1]);
        temp1=string(temp1);
        temp1=vector2str(temp1);
        unary=binaryVectorToDecimal(temp2);
        t=zeros(unary,1);
        for j=1:unary
            t(j)=1;
        end
        t(j+1)=0;
        t=string(t);
        t=vector2str(t);
        v(i)=strcat(temp1,t);
    end
end