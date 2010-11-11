dbnm = '../../../db/surveillance/';
DIR = dir(strcat(dbnm, '*.png'));
dbg = true;

DIR = DIR(1:150);

% bg-model
bg_med = bg_color(DIR, dbnm, dbg);

T = 50;
sz = length(DIR);

for f = 1:sz,
    imgnm = DIR(f).name;    
    cfrm = imread(strcat(dbnm, imgnm));  
    
    fark = uint8(abs(double(cfrm) - double(bg_med)));
    bw = (fark > T);
    
    figure(1);
    imshow(uint8(255*bw))
    drawnow;
end