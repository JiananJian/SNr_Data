path = '../data';
freq = [20, 10, 5];
edges = (0 : 0.01 : 1) / 20;
bnsz = edges(2) - edges(1);
file = ["D1 spike times - 20Hz", "D1-20Hz-wZD"; "GPe-PV spike times - spiketimes_20Hz", "GPe-20Hz-withZD"];
cell = ["D1-nZD", "D1-wZD"; "GPe-nZD", "GPe-wZD"]; n = size(file, 2);
for i = 1 : size(file, 1)
    figure(i); clf; 
    for j = 1 : n
        T = readtable(fullfile(path, file(i, j)));
        A = table2array(T(2 : end, :)) - 2; A(A < 0 | A >= 10) = nan;
        A(A >= 2.5) = nan; %%% comment for 10 sec, uncomment for 50 pulses
        
        v = mod(A, 1 / freq(1)); B = A - v;     B = floor(A*freq(1));
        C = B(1 : end, :) - B([end, 1 : end - 1], :); v(C == 0) = nan;
        N = histcounts(v, edges); r = N / size(A, 2) / bnsz;
        r = r  / (10 * freq(1));
        r = r  * freq(1) / freq(3); %%% comment for 10 sec, uncomment for 50 pulses
        subplot(n, 1, j); hold on;
        h = bar(edges(1 : end - 1), r, 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        ylabel('rate (Hz)'); ylim([0, 40]);
        title(cell(i, j)); 

    end
    xlabel('time (sec)');
end