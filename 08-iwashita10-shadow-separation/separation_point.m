function sp = separation_point(bw, dbg)
% function sp = separation_point(bw, dbg)

% 1. Hough transform
[H,T,R] = hough(bw);

P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));

theta = T(P(:,2))'; 
rho   = R(P(:,1))';

% % body
tidb = find(abs(theta) < 15);

sz = length(tidb);
for i=1:sz
    hb(i) = H(P(i, 1), P(i, 2));
end
[m, t] = max(hb);
idb = tidb(t);

% % shadow
tid = 1:length(theta);
tid(tidb) = [];
tids = tid;

sz = length(tids);
for i=1:sz
    hb(i) = H(P(i, 1), P(i, 2));
end
[m, t] = max(hb);
ids = tids(t);

% 2. y = mx + b
theta = theta([idb, ids]);
rho = rho([idb, ids]);

theta = deg2rad(theta);

m = - cos(theta) ./ sin(theta);
b = rho ./ sin(theta);

% 3. intersection
if abs(m(1)) == Inf
    x0 = rho(1);
    y0  = m(2)*x0 + b(2);
else
    x = 1:size(bw, 2);

    y1 = m(1)*x + b(1);
    y2 = m(2)*x + b(2);

    [x0, y0] = meetpoint(x, y1, x, y2);
end

sp = [x0, y0];

if dbg,
    figure(11);
    imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    plot(rad2deg(theta),rho,'s','color','green');
    hold off
end

