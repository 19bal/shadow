function I=MarkOther(mark, I3, I5)
[mm,nn]=size(I3);
  

   i=1;
   for j=1:nn;
       I3(i,j)=0;
   end
   i=mm;
   for j=1:nn;
       I3(i,j)=0;
   end
   j=1;
   for i=1:mm;
       I3(i,j)=0;
   end
   j=nn;
   for i=1:mm;
       I3(i,j)=0;
   end
   m=1;
   k=0;
while m~=0;
I=I3-I5;
[m,n]=find(I~=0);
NO=length(m);
dm=[-1,-1,-1,0,1,1,1,0];
dn=[-1,0,1,1,1,0,-1,-1];
for i=1:NO;
    for j=1:8;
        x=m(i)+dm(j);
        y=n(i)+dn(j);
        if mark(x,y)~=0&mark(x,y)~=1;
            mark(m(i),n(i))=mark(x,y);
            I5(m(i),n(i))=1;
            break;
            
       
        end
    end
end
k=k+1;

if k>200;%%%%%%%%%%%%%%%%%%%%%%%%%%
break;
end
end
I=mark;
