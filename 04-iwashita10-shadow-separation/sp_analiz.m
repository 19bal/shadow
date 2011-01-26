% function sp_analiz(dbg)
close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;
dip_initialise('silent');

dbnm   = pathos('_db/insan/');              % iwashita_insan_db.m
dbnm_gtruth = pathos('_db/gtruth/');        % https://github.com/downloads/19bal/shadow/surveillance_gtruth.tar.gz

% bboxs
load(strcat(dbnm, 'bbox.mat'));             % db_bbox(pathos('_db/insan/'), true);

% sp: sp_real_koord(true);
load(pathos('_bkp/sp_our_ky_real.mat'));    % 'SP_ky_r'
load(pathos('_bkp/sp_our_fe_real.mat'));    % 'SP_fe_r'
load(pathos('_bkp/sp_iwashita_real.mat'));  % 'SP_iw_r'

DIR = dir(strcat(dbnm, '*.png'));
DIR_gtruth = dir(strcat(dbnm_gtruth, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end

    gtruth = load('_db/gtruth/bbox.mat');   % db_bbox(pathos('_db/gtruth/'), true); % as gtruth.bboxs
    gtruth.img = imcrop(imread(strcat(dbnm_gtruth, DIR_gtruth(f).name)), gtruth.bboxs(f, :));

    frm = imread(strcat(dbnm, DIR(f).name));
    bw = imcrop(frm, bboxs(f, :));

    sp = round(SP_fe_r(f) - bboxs(f, 2) + 1);

    bwb = bw(1:sp,   :);    bwb = imcrop(bwb, bobox(bwb));
    bws = bw(sp:end, :);    bws = imcrop(bws, bobox(bws));
    
    % X. centroid'leri cakistir
    s = regionprops(double(gtruth.img), 'centroid', 'boundingbox');
    centroid_gt = cat(1, s.Centroid);
    bbox_gt = cat(1, s.BoundingBox);

    s = regionprops(double(bws), 'centroid', 'boundingbox');
    centroid_bs = cat(1, s.Centroid);
    bbox_bs = cat(1, s.BoundingBox);
    
    % a) kaydirma miktari
    kmX = round(centroid_bs(1) - centroid_gt(1));
    kmY = round(centroid_bs(2) - centroid_gt(2));
    
    % b) genisletilmis resmin-W | H
    W = ceil(max(size(gtruth.img, 2) + abs(kmX), size(bws, 2) + abs(kmX)));
    H = ceil(max(size(gtruth.img, 1) + abs(kmY), size(bws, 1) + abs(kmY)));
    
    % d) resimleri olustur
    y_bs = boolean(zeros(H, W));
    y_gt = boolean(zeros(H, W));
    
    kX = 1;         if kmX < 0,   kX = abs(kmX);   end
    kY = 1;         if kmY < 0,   kY = abs(kmY);   end
    y_bs(kY:(kY+size(bws,1)-1), kX:(kX+size(bws,2)-1)) = bws;
    
    kX = kmX;         if kmX <= 0,   kX = 1;   end
    kY = kmY;         if kmY <= 0,   kY = 1;   end
    y_gt(kY:(kY+size(gtruth.img,1)-1), kX:(kX+size(gtruth.img,2)-1)) = gtruth.img;
    
    if dbg, % edge(double(), 'canny'))
        if min(size(y_bs) == size(y_gt)) ~= 1
            error('Yeni resimlerin boyutlari farkli')
        end

        s = regionprops(double(y_gt), 'centroid'); 
        centroid_gt = cat(1, s.Centroid);
        
        s = regionprops(double(y_bs), 'centroid'); 
        centroid_bs = cat(1, s.Centroid);
        
        if max(abs(centroid_gt - centroid_bs)) > 2
            error('Agirlik merkezleri hala uzak!');
        end
        
        figure(11),
        subplot(221),   imshow(bw);                                         title('bw');
        subplot(222),   imshow(y_gt);          title('gtruth');
        subplot(223),   imshow(bwb);                 title('body');
        subplot(224),   
            t_bs = uint8(overlay(y_bs, edge(double(y_gt), 'canny'),  [255 0 0]));
            imshow(t_bs);   title('bws uzerine kirmizi: gtruth')
        drawnow
    end    
end
