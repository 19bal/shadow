% function sp = sp_ns_edge_width(dbnm_64x64, dbg)
% function sp = sp_ns_edge_width(dbnm_64x64, dbg)

DIR = dir(strcat(dbnm_64x64, '*.png'));
sz = 50;%length(DIR);

dip_initialise('silent');

for f = 1:sz,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f+50).name;    
    bw = imread(strcat(dbnm_64x64, imgnm));
    
    bwN(:,:,f) = bw;
    
    a = dip_image(bw);
    a_f = fillholes(a);
    a_fc = bclosing(a_f,1,-1,1);
    a_fcf = fillholes(a_fc);
    bw = logical(a_fcf);
    bw = bwareaopen(bw, 15);
    
    bwe = edge(uint8(255*bw), 'canny');
    bweN(:,:,f) = bwe;
    
    if dbg
        figure(1);
            bwoverlay = overlay(bw, bwe);
            imshow(uint8(bwoverlay));
        drawnow;
    end     
 
end

t = 1:64;

bwm  = uint8(255 * mean(double(bwN), 3));
bwem = uint8(255 * mean(double(bweN), 3));
bwm_x = sum(bwm, 2);
bwem_x = sum(bwem, 2);

figure(2), 
subplot(221),   imshow(bwm)
subplot(222),   plot(bwm_x, t)
subplot(223),   imshow(bwem)
subplot(224),   plot(bwem_x, t)

bwN_y = sum(double(bwN), 1);
bwN_x = sum(double(bwN), 2);

bwN_x_mn = mean(bwN_x, 3);
bwN_y_mn = mean(bwN_y, 3);

figure(3),  

subplot(221),  
hold on
for f=1:sz
    plot(t, bwN_x(:,1,f), 'k');
end
hold off

subplot(223),   plot(bwN_x_mn);

subplot(222),   
hold on
for f=1:sz
    plot(bwN_y(1,:,f), t, 'k');
end
hold off

subplot(224),   plot(bwN_y_mn, t);


figure(4)
tt = bwem > 0;
subplot(221),   imshow(tt)

tt = imfill(tt, 'holes');
subplot(222),   imshow(tt)

tt2 = imclose(bw, strel('disk', 3));
subplot(223),   imshow(tt2);

tt3 = tt | tt2;
subplot(224),   imshow(tt3)


% Asama 5:
% bw enerji resminin dis kenarlari goz onune alindiginda, 
% x-yonundeki iki dis kenar arasi mesafe body-shadow cizgisinde
% olmaktadir

% dis kenarlar
[r,c,v] = find(tt3);
[sr, ind] = sort(r);
sc = c(ind);
 
% genislik
for i=min(sr):max(sr)
    t = sc(sr == i);
    gen(i) = max(t) - min(t);
end

[mx, tt] = max(gen);

% polinom uydurarak global max noktasini belirle
% bu nokta sp:"separation point" tir
% eger "gen" egrisinde "sp" ye gelmeden onceki yerel tepeye
% bakilirsa bunun da "el" oldugu gorulebilir.
x = tt-10:tt+10;
y = gen(x);

p = polyfit(x, y, 2);

xx = min(x):0.01:max(x);
yy = polyval(p, xx);

[mx,ind]=max(yy);
sp = round(xx(ind));

figure(5),  
subplot(211),   plot(gen)
subplot(212),   plot(xx,yy);

