path = '../data/';
freq = [20, 10, 5]; n = length(freq);
file = ["D1 spike times - ", "GPe-PV spike times - spiketimes_"];
stim = ["D1", "GPe"];
for j = 1 : length(file)
    figure(j); clf; 
    for i = 1 : n
        T = readtable(fullfile(path, file(j) + num2str(freq(i)) + "Hz"));
        A = table2array(T(2 : end, :));
        edges = 0 : 0.2 : 15;
        bnsz = edges(2) - edges(1);
        N = histcounts(A, edges)  / size(A, 2) / bnsz;
        subplot(n, 1, i); hold on;
        h = bar(edges(1 : end - 1), N, 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        title(stim(j) + "-nZD-" + num2str(freq(i)) + "Hz"); xticks([0, 2, 12, 15]); 
        baseline = sum(A < 2, 'all') / 2 / size(A, 2);
        plot([0, 15], [1, 1] * baseline, '-k'); ylabel('rate (Hz)'); ylim([0, 30]);
    end
    xlabel('time (sec)');
end
