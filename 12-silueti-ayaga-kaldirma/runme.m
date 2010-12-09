clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/');

DIR = dir(strcat(dbnm, '*.jpg'));
sz = length(DIR);

for f=1:sz
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm, imgnm));

    bw = rgb2gray(bw);
    
    [cim, r, c, rsubp, csubp] = harris(bw, 1, 1000, 1, 1);
    
    cim = cim ./ max(cim(:));
    bwh = im2bw(cim, .2);
    
    numPeak = 6;
    [hgh, theta, rho, peakHghRC] = houghtr( bwh, numPeak );

    if dbg
        figure(1);
            subplot(121),   imshow(bw),        title('bw');
            subplot(122),   imshow(cim),        title('');
        drawnow;
    end    
    
end