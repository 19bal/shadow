function l=Intersecto(a,b,k,concave_v,Th)
    [m,n]=size(a);
    s=zeros(m,4);
    for i=1:m-1;
       s(i,:)=[a(i),b(i),a(i+1),b(i+1)];
    end    
    i=m;
    s(i,:)=[a(i),b(i),a(1),b(1)];
    
   
    if k==1;
    
        t=[a(m),b(m),a(2),b(2)];
    elseif k==m;
        t=[a(m-1),b(m-1),a(1),b(1)];
    else 
        t=[a(k-1),b(k-1),a(k+1),b(k+1)];
    end
    l=0;
    for j=1:m;
           if WheIn(t,s(j,:))==1;
              l=1*Min_Dis_Bver(a,b,k,concave_v,Th);
               break;
           end
    end

    
    
    
function temp=WheIn(s,t)
    
    A=[t(4)-t(2),t(1)-t(3);s(4)-s(2),s(1)-s(3)];
    B=[t(1)*t(4)-t(2)*t(3);s(1)*s(4)-s(2)*s(3)];
    %X=(ones(2)/A)*B;
    X=A\B;
    x=X(1);y=X(2);
    temp=0;
    d1=sqrt((x-t(1))^2+(y-t(2))^2);
    d2=sqrt((x-t(3))^2+(y-t(4))^2);
    d3=sqrt((x-s(1))^2+(y-s(2))^2);
    d4=sqrt((x-s(3))^2+(y-s(4))^2);
    d5=sqrt((t(1)-t(3))^2+(t(2)-t(4))^2);
    d6=sqrt((s(1)-s(3))^2+(s(2)-s(4))^2);
    
    
    
    if abs(d1+d2-d5)<=0.001&&abs(d3+d4-d6)<=0.001&&min([d1,d2,d3,d4])>0.01
        temp=1;
    end
%--------------    
function  temp1=Min_Dis_Bver(a,b,k,concave_v,Th);
x0=a(k);y0=b(k);

D=sqrt((x0-a).^2+(y0-b).^2);

l1=sort(D(concave_v));
if l1(1)~=0&&l1(1)>Th;
    temp1=0;
elseif l1(1)==0&&l1(2)>Th;
    temp1=0;
else
    temp1=1;
end
    
    

    
    