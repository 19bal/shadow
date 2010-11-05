clc;

dbnm = '../../db/surveillance/';
DIR = dir(strcat(dbnm, '*.png'));

sz = length(DIR);

for f=1:sz
    imgnm = DIR(f).name;
    cfrm = imread(strcat(dbnm, imgnm)); 
    
    figure(1),  
    subplot(221),   imshow(cfrm);
    subplot(222),   imshow(shadow_detection(cfrm));
    subplot(223),   imshow(shadow_remove(cfrm, 3));
    drawnow;
end