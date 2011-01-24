% function sp_analiz(dbg)
close all;  clear all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm   = pathos('_db/insan/');

% bboxs
load(strcat(dbnm, 'bbox.mat'));

% sp
load(pathos('_bkp/sp_our_ky_real.mat'));    % 'SP_ky_r'
load(pathos('_bkp/sp_our_fe_real.mat'));    % 'SP_fe_r'
load(pathos('_bkp/sp_iwashita_real.mat'));  % 'SP_iw_r'

DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor...\n', f); end
    
    frm = imread(strcat(dbnm, DIR(f).name));
    bw = imcrop(frm, bboxs(f, :));

    sp = round(SP_fe_r(f) - bboxs(f, 2) + 1);
    
    bwb = bw(1:sp,   :);
    bws = bw(sp:end, :);
    
    if dbg, 
        figure(11), 
        subplot(221),   imshow(bw);   
        subplot(223),   imshow(bwb);
        subplot(224),   imshow(bws);
        drawnow
    end
end
