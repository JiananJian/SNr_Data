path = '../data';
freq = [20, 10, 5]; n = length(freq);
edges = (0 : 0.005 : 1) / freq(3);
bnsz = edges(2) - edges(1);
file = ["D1 spike times - ", "GPe-PV spike times - spiketimes_"];
stim = ["D1", "GPe"];
for j = 1 : length(file)
    figure(j); clf; 
    for i = 1 : n
        T = readtable(fullfile(path, file(j) + num2str(freq(i)) + "Hz"));
        A = table2array(T(2 : end, :)) - 2; A(A < 0 | A >= 10) = nan;
        A(A >= 10 * freq(3) / freq(i)) = nan; %%% comment for 10 sec, uncomment for 50 pulses
        
        v = mod(A, 1 / freq(i)); B = A - v; 
        C = B(1 : end, :) - B([end, 1 : end - 1], :); v(C == 0) = nan;
        N = histcounts(v, edges); r = N / size(A, 2) / bnsz;
        r = r  / (10 * freq(i));
        r = r  * freq(i) / freq(3); %%% comment for 10 sec, uncomment for 50 pulses
        subplot(n, 1, i); hold on;
        h = bar(edges(1 : end - 1), r, 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        ylabel('rate (Hz)'); ylim([0, 40]);

        title(stim(j) + "-nZD-" + num2str(freq(i)) + "Hz"); 
    end
    xlabel('time (sec)');
end