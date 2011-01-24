function sp_annot()
%close all;  clear all;  clc;

global KY f

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/64x64/');    % ../07-medfilt-bgmodel/runme.m
DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

figure(1);
set(gcf, 'WindowButtonDownFcn', @down);

N = 7;

for f = 1:60 %sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm, imgnm));
    
    bw = imresize(bw, N);
    
    figure(1);  imshow(bw);
    pause
end

csvwrite(pathos('_db/annot/sp_annot.csv'), KY/N);

function down(h, e);
global KY f
cp = get(gca, 'CurrentPoint');

y = cp(1,2);
KY(f) = y;
disp(cp)
fprintf('y = %.1f\n', y);
