function [l,lc]=FindConvex(a,b,NOs)
i=1;
dx1 = a(i) - a(NOs);
dy1 = b(i) - b(NOs);
dx2 = a(i+1)-a(i) ;
dy2 = b(i+1)-b(i) ;
temp(i) = dx1*dy2 - dy1*dx2;
for i=2:NOs-1;
    dx1 = a(i)-a(i-1) ;
    dy1 = b(i)-b(i-1) ;
    dx2 = a(i+1)-a(i) ;
    dy2 = b(i+1)-b(i) ;
    temp(i) = dx1*dy2 - dy1*dx2;
end
i=NOs;
dx1 = a(i)-a(i-1) ;
dy1 = b(i)-b(i-1) ;
dx2 = a(1)-a(i) ;
dy2 = b(1)-b(i) ;
temp(i) = dx1*dy2 - dy1*dx2;

%%
l1=find(temp>0);
l2=find(temp<0);

if length(l1)>length(l2);
    l=l1;lc=l2;
else
    l=l2;lc=l1;
end
