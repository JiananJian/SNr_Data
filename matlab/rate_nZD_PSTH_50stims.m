path = '../data/';
freq = [20, 10, 5]; n = length(freq);
file = ["D1 spike times - ", "GPe-PV spike times - spiketimes_"];
stim = ["D1", "GPe"];
for j = 1 : length(file)
    figure(j); clf; 
    for i = 1 : n
        T = readtable(fullfile(path, file(j) + num2str(freq(i)) + "Hz"));
        A = table2array(T(2 : end, :)) - 2; A(A < 0 | A >= 10) = nan;
        A(A >= 10 * freq(3) / freq(i)) = nan;
        v = mod(A, 1 / freq(i));
        edges = (0 : 0.005 : 1) / freq(3);
        bnsz = edges(2) - edges(1);
        N = histcounts(v, edges) / size(A, 2) / bnsz;
        subplot(n, 1, i); hold on;
        h = bar(edges(1 : end - 1), N / (10 * freq(3)), 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        title(stim(j) + "-nZD-" + num2str(freq(i)) + "Hz"); 
        ylim([0, 40]);
    end
    xlabel('time (sec)');
end