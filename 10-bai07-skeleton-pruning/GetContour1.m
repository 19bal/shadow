function  [aa,bb,edge]=GetContour(bw)
%----------------------------------------
%Name: contour=GetContour(bw)
%Desc: To get the point's position along the boundary
%      bw is a n¡Án matrix
%Para: In bw, Non-zero point present the position of the shape
%Return:aa ,bb--the point's position along the boundary
%----------------------------------------
if max(max(bw))>1;

    I2=im2bw(bw,0.5);
else
    I2=bw;
end

[mm,nn]=size(bw);
   I3=bwperim(I2);
 edge=zeros(mm,nn);
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
   
   
   dx=[-1,-1,-1,0,1,1,1,0];
   dy=[-1,0,1,1,1,0,-1,-1];
   for i=1:mm;
       for j=1:nn;
       
           y=j;
           x=mm-i+1;
           if I3(x,y)==1;
               sx=x;
               sy=y;
           end
       end
   end
   cx=sx;
   cy=sy;
   temp=0;
   NO=1;
  
   bFindStartPoint = 0;
   while(~bFindStartPoint);
       aa(NO)=cx;
       bb(NO)=cy;
       edge(cx,cy)=1;
       bFindPoint =0;
       while ~bFindPoint;
               tx=cx+dx(temp+1);
               ty=cy+dy(temp+1);
               pixel = I3(tx,ty);
               if pixel==1;
                   bFindPoint = 1;
                   cx=tx;
                   cy=ty;
                   if cx==sx&cy==sy;
                       bFindStartPoint=1;
                   end
                   temp=temp-1;
                   if temp==-1;
                       temp=7;
                   end
                   temp=temp-1;
                   if temp==-1;
                       temp=7;
                   end
               else
                   temp=temp+1;
                   if temp==8;
                       temp=0;
                   end
               end
           end
           NO=NO+1;
           
       end

      
           
                   
           
                   
                   
   