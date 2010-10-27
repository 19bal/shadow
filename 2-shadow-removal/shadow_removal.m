function MovSC = shadow_removal(dbnm)
% function MovSC = shadow_removal(dbnm)

DIR = dir(strcat(dbnm, '*.png'));

% bg-model
imgnm = DIR(460).name;    
bgfrm = imread(strcat(dbnm, imgnm));    
bgimg = frm2nimg(bgfrm); 

frmInd = 700:1400; %fileinfo.NumFrames;

for f = frmInd,
    imgnm = DIR(f).name;    
    cfrm = imread(strcat(dbnm, imgnm));    
    
    nimg = frm2nimg(cfrm);
    
    A = imabsdiff (bgimg, nimg);
    A (A<0.31) = 0;
    A (A>=0.31) = 1;
    
    Res = imdilate (A,ones(9));

    GX = rgb2gray(bgfrm);
    GX1 = rgb2gray(cfrm);

    FD = im2double(imabsdiff(GX,GX1));
%     subplot(2,2,4)
%     imshow(FD)
    FD(FD<(0.1)) = 0;
    FD(FD>=(0.1)) = 1;

    DR = imdilate(FD,ones(3));
    re=  imfill(DR,'holes');
    
%     test = re.*(cos(X1(:,:,1)*2*pi).*X1(:,:,2));
%     test (test<0.15) = 0;
%     test (test>0.15) = 1;
%     B= imabsdiff (T,curFrame);
%     B (B<30) = 0 ;
%     B (B>30) = 1 ;
    finalRes(:,:,1) = Res(:,:,1).*re;
    finalRes(:,:,2) = Res(:,:,2).*re;
    finalRes(:,:,3) = Res(:,:,3).*re;
    
    boundaries = bwboundaries(rgb2gray(imclose(finalRes,ones(3))));
%     subplot(2,2,3)
%     imshow(imclose(finalRes,ones(3)))
    bndrSize = size(boundaries);
%     subplot(2,2,1:2)

    imshow(cfrm);
    hold on
    for k = 1:bndrSize(1)
        bnd = boundaries{k};
        RB2 = max(bnd);
        LT2 = min(bnd);
        if (max(RB2-LT2)>20)
%             plot(bnd(:,2),bnd(:,1),'r','LineWidth',1);
            rectangle('Position',[LT2(2),LT2(1),RB2(2)-LT2(2),RB2(1)-LT2(1)],'EdgeColor','g','LineWidth',1);
        end
    end
%     
%     bound = bwboundaries(imdilate(imerode(re,ones(5)),ones(5)));
%     BSize = size(bound);
%     for k = 1:BSize(1)
%         bnd = bound{k};
%         RB2 = max(bnd);
%         LT2 = min(bnd);
%         if (min(RB2-LT2)>20)
%             plot(bnd(:,2),bnd(:,1),'b','LineWidth',1);
%                 rectangle('Position',[LT2(2),LT2(1),RB2(2)-LT2(2),RB2(1)-LT2(1)],'EdgeColor','b','LineWidth',2);
%         end
%     end 
    MovSC(f-min(frmInd)+1) = getframe;
end

movie(MovSC);
