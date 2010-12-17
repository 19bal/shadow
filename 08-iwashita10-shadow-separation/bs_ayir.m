function [bwb, bws, ky] = bs_ayir(bw, dbg)
% function [bwb, bws, ky] = bs_ayir(bw, dbg)

% body
[r, c] = find(bw);

[sr, si] = sort(r);
sc = c(si);

% x - eksenindeki degisim
T = 10;
degisim = sc - min(sc);
id = find(degisim < T);

degisim_esiklenmis = degisim;
degisim_esiklenmis(id) = 0;

% kirilma noktasi: body-shadow
% tmp in '0' dan farklandigi "ilk" yerdir
id = find(degisim_esiklenmis);
id = id(1) - T;

if dbg    
    figure(31),
    plot(degisim);
    hold on
    plot(id, degisim(id), 'r*')
    hold off
    title('x-yonundeki degisim')
    xlabel('id');   ylabel('degisim')
    grid on
    text(id-4, 2, sprintf('sp:%d', id));
end

% koordinat karsiliklari
ky = sr(id);

bwb = bw(1:ky-1, :);
bws = bw(ky:end, :);

if dbg
    figure(32)
    subplot(221),   imshow(bw), title('bw')
 
    subplot(223),   imshow(bwb), title('bwb')
    subplot(224),   imshow(bws), title('bws')
end

