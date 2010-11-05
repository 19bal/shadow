clc;

dbnm = '../../db/surveillance/';
DIR = dir(strcat(dbnm, '*.png'));

sz = length(DIR);

while(1)
for f=[1:140 155:250]%sz
    imgnm = DIR(f).name;
    cfrm = imread(strcat(dbnm, imgnm)); 
    
    figure(1),  
    subplot(221),   imshow(cfrm);   title(num2str(f));
    subplot(222),   imshow(shadow_detection(cfrm));
    %subplot(223),   imshow(shadow_remove(cfrm, 3));
    drawnow;
end
end