function shadow = shadow_detection(frm)
% Detect shadow regions
[R,G,B] = get_average_color(frm);

shadow = (frm(:,:,1) > R) & (frm(:,:,2) > G) & (frm(:,:,3) > B);