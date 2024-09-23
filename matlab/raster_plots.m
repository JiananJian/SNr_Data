%% raster plot and histogram

%file = "GPe-PV spike times - spiketimes_20Hz"; freq = 20; titlename = 'GPe-nZD'; 
% file = "GPe-PV spike times - spiketimes_10Hz"; freq = 10; titlename = 'GPe-nZD-10Hz'; 
% file = "GPe-PV spike times - spiketimes_5Hz"; freq = 5; titlename = 'GPe-nZD-5Hz'; 
file = "D1 spike times - 20Hz"; freq = 20; titlename = 'D1-nZD'; 
% % file = "D1 spike times - 10Hz"; freq = 10; titlename = 'D1-nZD-10Hz'; 
% % file = "D1 spike times - 5Hz"; freq = 5; titlename = 'D1-nZD-5Hz'; 
% file = "GPe-20Hz-withZD"; freq = 20; titlename = 'GPe-wZD'; 
% file = "D1-20Hz-wZD"; freq = 20; titlename = 'D1-wZD'; 

A = makeSpikeMatrix(file);
[~, I] = sort(sum(A .* (A > 1 & A < 2) > 0)); A = A(:, I);
figure(2); clf; hold on;
makeRasterPlot(A, freq); title(titlename); xlim([1, 3]); 
figure(3); clf; hold on; 
makeHistogram(A); title(titlename);

edges = 2 : 1 / freq : 12;
N = zeros(length(edges) - 1, size(A, 2));
for i = 1 : size(A, 2)
    N(:, i) = histcounts(A(:, i), edges);
end

function A = makeSpikeMatrix(file) 
    path = '../data'; 
    T = readtable(fullfile(path, file), 'NumHeaderLines', 1);
    A = table2array(T); 
    [~, i] = sort(sum(~isnan(A))); A = A(:, i);
end

function makeRasterPlot(A, freq)
    stim = 2 : 1 / freq : 12; m = length(stim);
    n = size(A, 2); 
    plot(ones(2, 1) * stim, [0; n + 1] * ones(1, m), '-b'); 
    plot(A, 1 : n, '.k');
    xticks([0, 2, 12, 15]); yticks(1 : n);
    xlabel('time (sec)'); ylabel('cells'); ylim([0, n + 1]);
end

function makeHistogram(A)
    freq = 1 / 10; stim = 2 : 1 / freq : 12; m = length(stim);
    bnsz = .1; edges = 0 : bnsz : 15;
    n = size(A, 2); N = histcounts(A, edges); 
    
    h = bar(edges(1 : end - 1), N / n / bnsz, 'histc');
    h.EdgeColor = 'none'; h.FaceColor = 'r';
    plot(ones(2, 1) * stim, gca().YLim' * ones(1, m), '-b'); 
    xticks([0, 2, 12, 15]); 
    xlabel('time (sec)'); ylabel('rate (Hz)'); xlim(edges([1, end])); 
end