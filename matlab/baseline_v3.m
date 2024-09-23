path = '../data'; 
files = [...
%     "GPe-PV spike times - spiketimes_20Hz", "D1 spike times - 20Hz", ...
%     "GPe-PV spike times - spiketimes_10Hz", "D1 spike times - 10Hz", ...
     "GPe-PV spike times - spiketimes_5Hz", "D1 spike times - 5Hz", ...
    ];    
freq = 5; 
isi = cell(size(files)); fspk = cell(size(files)); lspk = cell(size(files));  
for i = 1 : length(files)
    file = files(i);
    T = readtable(fullfile(path, file));
    A = table2array(T(2 : end, :)); A(A >= 2) = nan;
    a = A(2 : end, :) - A(1 : end - 1, :);
    isi{i} = a(:);

    B = floor(A * freq); %  to sample first spikes
    C = B(1 : end, :) - B([1, 1 : end - 1], :); C(1, :) = 1;
    fspk{i} = mod(A(~isnan(A) & C ~= 0), 1 / freq);

    A(isnan(A)) = -1; 
    B = floor(A * freq); %  to sample last spikes
    C = B(1 : end, :) - [B(2 : end, :); -freq * ones(1, size(A, 2))]; 
    lspk{i} = mod(A(C ~= 0), 1 / freq) - 1 / freq;
end
isi = vertcat(isi{:}); isi(isnan(isi)) = [];
bnsz = 0.001; edges = 0 : bnsz : 0.2; 
r = histcounts(isi, edges) / length(isi) / bnsz; 

figure(1); clf; hold on;
h = bar(edges(1 : end - 1), r, 'histc');
h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
xlabel('isi (sec)'); ylabel('pdf (1/sec)');

% calculate first spike rate
fspk = vertcat(fspk{:}); 
bnsz = 0.001; edges = 0 : bnsz : 0.2; 
r = histcounts(fspk, edges) / sum(~isnan(fspk)) / bnsz; 

% plot first spike rate
figure(2); clf; hold on; xlim(edges([1, end])); 
h = bar(edges(1 : end - 1), r, 'histc');
h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
xlabel('t_{spk}^1 (sec)', 'FontSize', 15); ylabel('pdf (1/sec)', 'FontSize', 15);

% theoretical plot
isi = sort(isi); 
pdf = cumsum(1 ./ isi, 'reverse') / length(isi);
% stairs([0; isi], [pdf; 0], 'k'); % untrancated trace

i = find(isi > 1 / freq, 1); isi(i) = 1 / freq;
s = pdf(1 : i)' * (isi(1 : i) - [0; isi(1 : i - 1)]);
stairs([0; isi(1 : i)], [pdf(1 : i); 0] / s, 'k', 'LineWidth', 2); % trancated trace

% calculate last spike rate
lspk = vertcat(lspk{:}); 
bnsz = 0.001; edges = -0.2 : bnsz : 0; 
r = histcounts(lspk, edges) / sum(~isnan(lspk)) / bnsz; 

% plot last spike rate
xlim(-edges(1) * [-1, 1] / 2); 
h = bar(edges(1 : end - 1), r, 'histc');
h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
xlabel('t_{spk}^{\pm 1} (sec)', 'FontSize', 15); ylabel('pdf (1/sec)', 'FontSize', 15);

% theoretical plot
stairs(-[0; isi(1 : i)], [pdf(1 : i); 0] / s, 'k', 'LineWidth', 2); % trancated trace

legend('data', 'prediction')