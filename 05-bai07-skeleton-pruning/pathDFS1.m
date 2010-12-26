function [P,S] = pathDFS1(bw,u,v)
%2006/12/23 by Xiang Bai
%run first Test.m
%To trace the path between skeleton endpoints
%Depth-first search from a start point u to an end point v
%[P,S]=pathDFS1(bw,[x1(1),y1(1)],[x1(2),y1(2)]);
%bw is skeleton map
%x1 and y1 are the vertices of DCE
%S is skeleton MAP
%P is path
%%% This is the same with pathDFS
%to view
%plot the skeleton first
%plot(P(:,2),P(:,1),'g')
%flip x and y coordinate

[m,n] = size(bw);
bAccess = zeros(m,n);
u=findadjancentp(bw,u);
v=findadjancentp(bw,v);

%access stack
AccessStack = u;
bAccess(u(1),u(2)) = 1;
GStack=[u];

% from the start point, check the 4-adjent points and the 8-adjent points
while (length(AccessStack) ~= 0);
    curPoint = AccessStack(1,:);
    [tm,tn] = size(AccessStack);
    AccessStack = AccessStack(2:tm,:);
    nAdj = 0;
    for i = max(curPoint(1)-1,1):min(curPoint(1)+1,m);
        for j = max(curPoint(2)-1,1):min(curPoint(2)+1,n);
            if bAccess(i,j) == 0;
             
                if bw(i,j) ~= 0;
                    bAccess(i,j) = 1;
                    nAdj = nAdj+1;
                    AccessStack = [[i,j];AccessStack];
                    
                    GStack = [[i,j];GStack];
                    if i==v(1)&j==v(2)

                         temp1=GStack;
%                          test = AccessStack;
                    end
                else
                    bAccess(i,j) = -1;
                end;
            end;
        end;
    end;
    
end;


S=bAccess;
G=temp1;

P=[];
P = G(1,:);
while length(G) > 2  
    %curPoint = G(1,:);
    [tm, tn] = size(G);
    
    G = G(2:tm,:);
      
    %P = curPoint;
  if disp(P(1,:),G(1,:))<=2 %& tm ~=1 
       
        P = [G(1,:);P];
        
    end
end

P = [G(2,:);P];
% [G]=temp;
      
 
 
 
function p2=findadjancentp(I,p1)
[m,n]=find(I ~= 0);
D=(p1(1)-m).^2+(p1(2)-n).^2;
k=find(D == min(D));
p2=[m(k(1)),n(k(1))];

function ds=disp(p1,p2)
ds = (p1(1) - p2(1))^2+(p1(2) - p2(2))^2;