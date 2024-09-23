path = '../data/';
edges = 0 : 1e-1 : 15;
bnsz = edges(2) - edges(1);
file = ["D1 spike times - 20Hz", "D1-20Hz-wZD"; "GPe-PV spike times - spiketimes_20Hz", "GPe-20Hz-withZD"];
cell = ["D1-nZD", "D1-wZD"; "GPe-nZD", "GPe-wZD"]; n = size(file, 2);
for i = 1 : size(file, 1)
    figure(i); clf; 
    for j = 1 : n
        T = readtable(fullfile(path, file(i, j)));
        A = table2array(T(2 : end, :));
        N = histcounts(A, edges);
        subplot(n, 1, j);
        h = bar(edges(1 : end - 1), N / size(A, 2) / bnsz, 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        title(cell(i, j)); xticks([0, 2, 12, 15]);
    end
end
