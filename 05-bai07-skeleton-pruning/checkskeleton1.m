function bsk=checkskeleton1(bw,dist,lab,i,j,ro,mark)


[m,n] = size(dist);%变换矩阵的大小
bsk = 0;
%距离8领域点pi最近边界点的坐标列表
qNeighbor = [];
nNeighbor = 0;
%距离p点最近边界点的坐标
[q(1),q(2)] = Lab2Pos(lab(i,j),m,n);

q = q-[j,i];
for qi = max(i-1,1):min(i+1,m);
    for qj = max(j-1,1):min(j+1,n);
        bIn = false;
        if bw(qi,qj) == 0 & any([i,j]~=[qi,qj]);
            [tq(1),tq(2)] = Lab2Pos(lab(qi,qj),m,n);
            tq = tq-[j,i];
            for k = 1:nNeighbor;
                if all(tq == qNeighbor(k,:));
                    bIn  = true;
                    break;
                end;
            end;
        
        
            if ~bIn & length(tq) ~= 0;
                nNeighbor = nNeighbor+1;
                qNeighbor  = [qNeighbor;tq];
            end;
        end;
    end;
end;

%对每一个(qi,q)检查连接约束和宽度约束
bIsSkeleton = false;
pro =2*dist(i,j)^2;
%proo=dist(i,j)^2/16;
for k = 1:nNeighbor;
    d = sum((q-qNeighbor(k,:)).^2);
    a1=q(1)+j;
    b1=q(2)+i;
    a2=qNeighbor(k,1)+j;
    b2=qNeighbor(k,2)+i;
    %temp=(a2-a1)^2+(b2-b1)^2
    %if d >= ro
   if d >= min(pro,ro);
   
       if abs(sum(q.^2) - sum(qNeighbor(k,:).^2)) <=1*max(abs( q-qNeighbor(k,:)))&&mark(b1,a1)~=mark(b2,a2)%&&temp>121;
          
            bIsSkeleton = true;
            break;
        end;
    end;
end;

if bIsSkeleton;
    bsk = dist(i,j);
end;

                
                            
        
        