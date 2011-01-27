function [y_gt, y_bws] = shadow_cakistir(gt, bws, dbg)
% function shadow_cakistir(gt, bws, dbg)
% 
% "gt" resmini, "bws" uzerine cakistir.

dip_initialise('silent');

% X. centroid'leri cakistir
s = regionprops(double(gt), 'centroid', 'boundingbox');
centroid_gt = cat(1, s.Centroid);
bbox_gt     = cat(1, s.BoundingBox);

s = regionprops(double(bws), 'centroid', 'boundingbox');
centroid_bs = cat(1, s.Centroid);
bbox_bs     = cat(1, s.BoundingBox);

% a) kaydirma miktari
kmX = round(centroid_bs(1) - centroid_gt(1));
kmY = round(centroid_bs(2) - centroid_gt(2));

% b) genisletilmis resmin-W | H
W = ceil(max(size(gt, 2) + abs(kmX), size(bws, 2) + abs(kmX)));
H = ceil(max(size(gt, 1) + abs(kmY), size(bws, 1) + abs(kmY)));

% d) resimleri olustur
y_bws = boolean(zeros(H, W));
y_gt = boolean(zeros(H, W));

kX = 1;         if kmX < 0,   kX = abs(kmX);   end
kY = 1;         if kmY < 0,   kY = abs(kmY);   end
y_bws(kY:(kY+size(bws,1)-1), kX:(kX+size(bws,2)-1)) = bws;

kX = kmX;         if kmX <= 0,   kX = 1;   end
kY = kmY;         if kmY <= 0,   kY = 1;   end
y_gt(kY:(kY+size(gt,1)-1), kX:(kX+size(gt,2)-1)) = gt;

if min(size(y_bws) == size(y_gt)) ~= 1
    error('Yeni resimlerin boyutlari farkli')
end

s = regionprops(double(y_gt), 'centroid'); 
centroid_gt = cat(1, s.Centroid);

s = regionprops(double(y_bws), 'centroid'); 
centroid_bs = cat(1, s.Centroid);

if max(abs(centroid_gt - centroid_bs)) > 2
    error('Agirlik merkezleri hala uzak!');
end
