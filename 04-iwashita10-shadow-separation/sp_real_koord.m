function sp_real_koord(dbg);

% SP: runme.m
load(pathos('_bkp/sp_our_ky.mat'));
load(pathos('_bkp/sp_our_fe.mat'));
load(pathos('_bkp/sp_iwashita.mat'));

% BBOX
bbox_insan = db_bbox(pathos('_db/insan/'), dbg);    % db_bbox(pathos('_db/insan/'), true);
bbox_64x64 = db_bbox(pathos('_db/64x64/'), dbg);    % db_bbox(pathos('_db/64x64/'), true);

sz = min([length(bbox_insan), length(bbox_64x64), length(SP_ky), length(SP_fe)]);
bbox_insan = bbox_insan(1:sz, :);
bbox_64x64 = bbox_64x64(1:sz, :);
SP_ky = SP_ky(1:sz);        SP_ky = SP_ky(:);
SP_fe = SP_fe(1:sz);        SP_fe = SP_fe(:);
SP_iw = sp * ones(sz, 1);   SP_iw = SP_iw(:);

SP_ky_r = sp_toreal_coord(SP_ky, bbox_insan, bbox_64x64, dbg);
SP_fe_r = sp_toreal_coord(SP_fe, bbox_insan, bbox_64x64, dbg);
SP_iw_r = sp_toreal_coord(SP_iw, bbox_insan, bbox_64x64, dbg);

if dbg,
    figure(11),
    x = 1:sz;
    plot(x, SP_ky_r, 'r', x, SP_fe_r, 'b', x, SP_iw_r, 'g');
    legend('our-v1', 'our-v2', 'iw');
end

save(pathos('_bkp/sp_our_ky_real.mat'), 'SP_ky_r');
save(pathos('_bkp/sp_our_fe_real.mat'), 'SP_fe_r');
save(pathos('_bkp/sp_iwashita_real.mat'), 'SP_iw_r');
