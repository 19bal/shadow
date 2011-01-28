% function sp_analiz(dbg)
close all;  clear all;  clc;
warning off all;

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

% coord: real to bbox => orjinal resim koordinatlar?ndan bbox icerisi koord
SP_ky_r = round(SP_ky_r - bboxs(:, 2) + 1);
SP_fe_r = round(SP_fe_r - bboxs(:, 2) + 1);
SP_iw_r = round(SP_iw_r - bboxs(:, 2) + 1);

DIR = dir(strcat(dbnm, '*.png'));
DIR_gtruth = dir(strcat(dbnm_gtruth, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end

    gtruth = load('_db/gtruth/bbox.mat');   % db_bbox(pathos('_db/gtruth/'), true); % as gtruth.bboxs
    gtruth.img = imcrop(imread(strcat(dbnm_gtruth, DIR_gtruth(f).name)), gtruth.bboxs(f, :));

    frm = imread(strcat(dbnm, DIR(f).name));
    bw = imcrop(frm, bboxs(f, :));
    
    gt = gtruth.img;
    
    [bws_ky, gt_ky, err_ky(f)] = sp_analiz_helper(bw, gt, SP_ky_r(f), dbg);
    [bws_fe, gt_fe, err_fe(f)] = sp_analiz_helper(bw, gt, SP_fe_r(f), dbg);
    [bws_iw, gt_iw, err_iw(f)] = sp_analiz_helper(bw, gt, SP_iw_r(f), dbg);
    
    if dbg,
        figure(1),
        subplot(221)
            t_bs = uint8(overlay(bws_ky, edge(double(gt_ky), 'canny'),  [255 0 0]));
            imshow(t_bs);   
            title('KY')
        subplot(222)
            t_bs = uint8(overlay(bws_fe, edge(double(gt_fe), 'canny'),  [255 0 0]));
            imshow(t_bs);   
            title('FE')
        subplot(223)
            t_bs = uint8(overlay(bws_iw, edge(double(gt_iw), 'canny'),  [255 0 0]));
            imshow(t_bs);   
            title('Iwashita')            
        pause(0.3); drawnow
    end
end

% karsilastirmali sonuclar
mse_ky = cat(1, err_ky.mse);
mse_fe = cat(1, err_fe.mse);
mse_iw = cat(1, err_iw.mse);

t = [mse_ky mse_fe mse_iw]';
[mn, idx] = min(t);
fe_num = find(idx == 2);


fprintf('SONUCLAR:\n');

fprintf('\tError:\n');
fprintf('\tKY: %.3f +- %.3f\n\tFE: %.3f +- %.3f\n\tIW: %.3f +- %.3f\n\n', ...
        mean(mse_ky), std(mse_ky), mean(mse_fe), std(mse_fe), ...
        mean(mse_iw), std(mse_iw));

fprintf('\tENIYILER: toplam %d adet veri var...\n', length(err_ky));
fprintf('\tKY: %d, FE: %d, IW: %d\n\n', ...
        length(find(idx == 1)), length(find(idx == 2)), ...
        length(find(idx == 3)));
