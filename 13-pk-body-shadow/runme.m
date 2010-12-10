clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%slib%s', filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/');

DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

for f=1:sz
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    bw = imread(strcat(dbnm, imgnm));

    T = maketform('affine', ...
        [4 0 0; ...
         2 4 0; ...
         0 0 1]);
    
    J = imtransform(bw, T);
    
    if dbg
        figure(1);
            subplot(121),   imshow(bw),        title('bw');
            subplot(122),   imshow(J),        title('');
        drawnow;
    end    
    
end