function [sp, bbH, bbW] = sp_iwashita(dbnm, dbg)
% function [sp, bbH, bbW] = sp_iwashita(dbnm, dbg)
%
% Usage:
%
% sp_iwashita
% close all;  clear all;  clc;
%
% %%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
% addpath(LIB_PATH,'-end');                                                 %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% dbg = true;
%
% dbnm   = pathos('_db/bw/');    % ../07-medfilt-bgmodel/runme.m
% sp = sp_iwashita(dbnm, dbg)

dbnm_insan = pathos('_db/insan/');

iwashita_insan_db(dbnm, dbnm_insan, dbg);

DIR = dir(strcat(dbnm_insan, '*.png'));
sz = length(DIR);

dip_initialise('silent');

for f = 1:sz,
    if dbg, fprintf('kare %04d/%04d isleniyor ...\n', f, sz);   end

    imgnm = DIR(f).name;
    bw = imread(strcat(dbnm_insan, imgnm));

    frms(:,:,f) = bw;

    if dbg
        figure(11);  imshow(bw);
        drawnow;
    end

end

% % separation point
mn = mean(double(frms), 3);
mn = uint8(255 * mn / max(mn(:)));

bw_mn = (mn > 0);
s = regionprops(bwlabel(bw_mn), 'orientation', 'boundingbox');
mn_rot = imrotate(mn, deg2rad(-s.Orientation), 'bilinear', 'crop');

mn_x = sum(mn_rot, 2);
y = sgolayfilt(mn_x, 2, 11);

if dbg
    t=1:size(mn_rot, 1);

    figure(12),     imshow(mn_rot)
    figure(13),     plot(t, y)
end

y2 = y; y2(y2 < 100) = 0;
[lmnv, lmni] = lmin(y2, 2);
[lmxv, lmxi] = lmax(y2, 2);

[t, i] = max(lmxv);
Ya = lmxi(i);

[t, i] = min(lmnv);
Yb = lmni(i);

sp = (Ya + Yb) / 2;             % mutlak koordinat

sp = sp - s.BoundingBox(2);     % bbox a gore, goreceli koordinat

bbW = s.BoundingBox(3);
bbH = s.BoundingBox(4);

