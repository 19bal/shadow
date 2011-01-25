function spr = sp_toreal_coord(sp, bbox_buyuk, bbox_kucuk, dbg)

% olcekle
spr = sp .* bbox_buyuk(:, 3) ./ bbox_kucuk(:, 3);

% otele
spr = spr + bbox_buyuk(:, 2) - 1;

% if length(sp) == 2    
% else
% end
