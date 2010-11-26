
function [bw,I0,x,y,x1,y1,aa,bb]=div_skeleton_new(ro,T1,I0,no_vertice)
%Output: bw is skeleton image, I0 is original image
%        [x,y] is DCE verices, and [x1,y1] is skeleton endpoints
%        [aa,bb] is the original contour 
%input : ro is always set as 4, and 
%T1 is the parameter for evaluating the intersection, it is distance in pixels
%I0 is the input binary image, 
%no_vertice is the number of vertices of the polygon similified by DCE.



if max(max(I0))>1;
I0=im2bw(I0);
end
%I0=1-I0;%add
%[aa,bb,I5]=GetContour(I0);
 [aa,bb,I5]=GetContour1(I0);

%[aa,bb]=TraceContour(I1)

%I2=im2bw(I1,0.5);
I3=bwperim(I0);

[s,value]=evolution([aa',bb'],no_vertice);
a=s(:,1);
b=s(:,2);
NO=length(a);

 
    [convex_temp,concave_temp]=FindConvex(a,b,NO);
     convex=zeros(1,NO);
     convex(convex_temp)=1;
  
   m=length(a);
    for i=1:m;
        intersect(i)=Intersecto(a,b,i,concave_temp,T1);
    end
    final=convex-intersect;
    remain=find(final==1);
    NONO=length(remain);
    aaa=a(remain); bbb=b(remain);

mark=Curvediv1(aa,bb,aaa,bbb,NONO,I3);
[p,q]=find(mark~=0);
u=length(p);
for i=1:u;
    mark(p(i),q(i))=mark(p(i),q(i))+1;
end
mark=MarkOther(mark, I3, I5);
bw=SkeletonGrow1(I0,ro,mark);
x=a;
x(NO+1)=a(1);
y=b;
y(NO+1)=b(1);
x1=aaa;
y1=bbb;

%figure;plot(x,y);
%figure;plot(aa,bb);
