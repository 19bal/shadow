function bg_med = bg_color(DIR, dbnm, dbg) 
for f=1:len(DIR),
    imgnm = DIR(f).name;    
    img = imread(strcat(dbnm, imgnm));
    
    frm(:,:,:,f) = img;
end

%% a) mean
%   frame indisince ortalama
%   tum framelerin ortalamasi: resim (RGB)
bg_mn = median(double(frm), 4);

if dbg,
    figure(2);              imshow(uint8(bg_mn));
    title('Mean image');    drawnow;
end
