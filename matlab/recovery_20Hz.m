%% rate recovery
path = '.';
freq = [20, 10, 5]; n = freq(1)/freq(3);
file = ["D1 spike times - ", "GPe-PV spike times - spiketimes_"];
stim = ["D1", "GPe"];
for j = 1 : length(file)
    figure(j); clf; 
    for i = 1 : n
        T = readtable(fullfile(path, file(j) + num2str(freq(1)) + "Hz"));
        A = table2array(T(2 : end, :)) - 2; A(A < 0 | A >= 10) = nan;
        A(A >= 10 * freq(3) / freq(1) * i | A < 10 * freq(3) / freq(1) * (i-1)) = nan;
        v = mod(A, 1 / freq(1));
        edges = (0 : 0.005 : 1) / freq(3);
        bnsz = edges(2) - edges(1);
        N = histcounts(v, edges) / size(A, 2) / bnsz;
        subplot(n, 1, i); hold on;
        h = bar(edges(1 : end - 1), N / (10 * freq(3)), 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        title(stim(j) + "-nZD-" + num2str(freq(1)) + "Hz  " + num2str(10 * freq(3) / freq(1) * (i-1)) + ":" + num2str(10 * freq(3) / freq(1) * i)); 
        ylim([0, 40]);
    end
    xlabel('time (sec)');
end

%% first spike recovery
path = '.';
freq = [20, 10, 5]; n = freq(1)/freq(3);
edges = (0 : 0.002 : 1) / freq(3);
bnsz = edges(2) - edges(1);
file = ["D1 spike times - ", "GPe-PV spike times - spiketimes_"];
stim = ["D1", "GPe"];
for j = 1 : length(file)
    figure(j); clf; 
    for i = 1 : n
        T = readtable(fullfile(path, file(j) + num2str(freq(1)) + "Hz"));
        A = table2array(T(2 : end, :)) - 2; A(A < 0 | A >= 10) = nan;
        A(A >= 10 * freq(3) / freq(1) * i | A < 10 * freq(3) / freq(1) * (i-1)) = nan;
        
        v = mod(A, 1 / freq(1)); B = A - v; 
        C = B(1 : end, :) - B([end, 1 : end - 1], :); v(C == 0) = nan;
        N = histcounts(v, edges); r = N / size(A, 2) / bnsz;
        r = r  / (10 * freq(1));
        r = r  * freq(1) / freq(3); 
        subplot(n, 1, i); hold on;
        h = bar(edges(1 : end - 1), r, 'histc');
        h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
        ylabel('rate (Hz)'); ylim([0, 40]);
        
        title(stim(j) + "-nZD-" + num2str(freq(1)) + "Hz  " + num2str(10 * freq(3) / freq(1) * (i-1)) + ":" + num2str(10 * freq(3) / freq(1) * i)); 
        

    end
    xlabel('time (sec)');
end