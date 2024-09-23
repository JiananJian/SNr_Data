path = '../data/';
edges = (0 : 0.01 : 1) / 20;
bnsz = edges(2) - edges(1);
file = ["D1 spike times - 20Hz", "D1-20Hz-wZD"; "GPe-PV spike times - spiketimes_20Hz", "GPe-20Hz-withZD"];
cell = ["D1-nZD", "D1-wZD"; "GPe-nZD", "GPe-wZD"]; n = size(file, 2);
for i = 1 : size(file, 1)
    figure(i+10); clf; 
    for j = 1 : n
        T = readtable(fullfile(path, file(i, j)));
        A = table2array(T(2 : end, :)) - 2; A(A < 0 | A >= 10) = nan;

        v = mod(A, 1 / freq(1)); B = A - v;     B = floor(A*freq(1));
        C = B(1 : end, :) - B([end, 1 : end - 1], :); v(C == 0) = nan;

        N = histcounts(v, edges) / size(A, 2) / bnsz;
        subplot(n, 1, j);
        h = bar(edges(1 : end - 1), N / (10 * 20), 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        title(cell(i, j)); 
    end
end