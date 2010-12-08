function I=Curvediv1(orx,ory,endx,endy,nume,bw)
%-------------------------------------------
%Name: Curvediv,make signs to boundary curve
%Para: orx,ory----original curve
%      endx,endy--curve after convolution
%      bw---------oringnal graphic
%      I----------a matrix with marks
M=length(orx);
%N=length(endx);
N=nume;
[MM,NN]=size(bw);
I=zeros(MM,NN);
for i=1:N-1;
    for j=1:M;
        if endx(i)==orx(j)&&endy(i)==ory(j);
            temp1=j;
        end
        if endx(i+1)==orx(j)&&endy(i+1)==ory(j);
            temp2=j;
        end
    end
    if temp2>temp1;
       for k=temp1:temp2-1;
           I(orx(k),ory(k))=i+1;
       end
    else temp1>temp2;
       for k=temp1:M;
           I(orx(k),ory(k))=i+1;
       end
       for k=1:temp2-1;
           I(orx(k),ory(k))=i+1;
       end
    end
        
end

i=N;
    for j=1:M;
        if endx(i)==orx(j)&&endy(i)==ory(j);
            temp1=j;
        end
        if endx(1)==orx(j)&&endy(1)==ory(j);
            temp2=j;
        end
    end
    if temp2>temp1;
       for k=temp1:temp2-1;
           I(orx(k),ory(k))=i+1;
       end
    else temp1>temp2;
       for k=temp1:M;
           I(orx(k),ory(k))=i+1;
       end
       for k=1:temp2-1;
           I(orx(k),ory(k))=i+1;
       end
    end
    
    %Z=zeros(MM,NN);
            
    %for i=1:M,
     %   if rem(I(orx(i),ory(i)),2)==1
     %       Z(orx(i),ory(i))=1;
      %  elseif rem(I(orx(i),ory(i)),2)==0
       %      Z(orx(i),ory(i))=2;
        %end
    %end
    %imshow(Z,[]);
         