%% raster plot and histogram

file = "GPe-20Hz-withZD"; 
A1 = makeSpikeMatrix(file); [m1, n1] = size(A1); 
file = "D1-20Hz-wZD";
A2 = makeSpikeMatrix(file); [m2, n2] = size(A2); 
m = max(m1, m2); n = n1 + n2; A = nan(m, n);
A(1 : m1, 1 : n1) = A1; A(1 : m2, n1 + (1 : n2)) = A2;
A(A > 2) = nan; A(A < 1) = nan;
[~, i] = sort(sum(~isnan(A))); A = A(:, i);
figure(2); clf; hold on;
plot(A, (1 : n) / n, '.k');

%
file = "GPe-PV spike times - spiketimes_20Hz"; 
A1 = makeSpikeMatrix(file); [m1, n1] = size(A1); 
file = "D1 spike times - 20Hz";
A2 = makeSpikeMatrix(file); [m2, n2] = size(A2); 
m = max(m1, m2); n = n1 + n2; A = nan(m, n);
A(1 : m1, 1 : n1) = A1; A(1 : m2, n1 + (1 : n2)) = A2;
A(A > 2) = nan; A(A < 1) = nan;
[~, i] = sort(sum(~isnan(A))); A = A(:, i); 
A = A - 1; plot([1, 1], [0, 1], 'b');
plot(A, (1 : n) / n, '.k');
title('raster plot'); xticks([0.5, 1.5]); xticklabels({'nZD', 'wZD'});

function A = makeSpikeMatrix(file) 
    path = '../data'; 
    T = readtable(fullfile(path, file), 'NumHeaderLines', 1);
    A = table2array(T); 
    [~, i] = sort(sum(~isnan(A))); A = A(:, i);
end
