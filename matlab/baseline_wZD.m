path = '.'; file="GPe-20Hz-withZD"; %file="D1-20Hz-wZD";
T = readtable(fullfile(path, file));
A = table2array(T(2 : end, :));

%% isi
figure(1); clf; hold on;
isi = A(2 : end, :) - A(1 : end - 1, :);
edges = (0 : 0.01 : 1) / 20; bnsz = edges(2) - edges(1);
N = histcounts(isi, edges);
h = bar(edges(1 : end - 1), N, 'histc');
h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
for i = 1 : size(isi, 2)
    N = histcounts(isi(:, i), edges);
    plot(edges(1 : end - 1) + bnsz / 2, N, 'k');
end
xlabel('isi (sec)'); ylabel('counts');

%% 15sec
figure(2); clf;
freq = [20]; n = length(freq);
edges = 0 : 0.02 : 15; bnsz = edges(2) - edges(1);
N = histcounts(A, edges); r = N / size(A, 2) / bnsz;
for i = 1 : n
    subplot(n, 1, i); hold on;
    h = bar(edges(1 : end - 1), r, 'histc');
    h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
    xticks([0, 2, 12, 15]); ylabel('rate (Hz)');
    title("baseline"); 
end
xlabel('time (sec)');

%% .2sec
A(A >= 2 & A < 12) = nan;
figure(3); clf;
edges = (0 : 0.01 : 1) / 20; bnsz = edges(2) - edges(1);
for i = 1 : n
    v = mod(A, 1 / freq(i)); % freq is interpreted as sampling rate of each subplot
    N = histcounts(v, edges); r = N / size(A, 2) / bnsz;
    r = r  / (10 * freq(i));
    subplot(n, 1, i); hold on;
    h = bar(edges(1 : end - 1), r, 'histc');
    h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
    ylabel('rate (Hz)');
    title("baseline - " + num2str(freq(i)) + "Hz");
end
xlabel('time (sec)');

%% 1st spike
figure(4); clf;
edges = (0 : 0.005 : 1) / 5; bnsz = edges(2) - edges(1);
for i = 1 : n
    v = mod(A, 1 / freq(i)); B = A - v; 
    C = B(1 : end, :) - B([end, 1 : end - 1], :); v(C == 0) = nan;
    N = histcounts(v, edges); r = N / size(A, 2) / bnsz;
    r = r  / (10 * freq(i));
    subplot(n, 1, i); hold on;
    h = bar(edges(1 : end - 1), r, 'histc');
    h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
    ylabel('rate (Hz)'); ylim([0, 40]);
    title("baseline - " + num2str(freq(i)) + "Hz");
%     for k = 1 : size(A, 2)
%         N = histcounts(v(:, k), edges); r = N / bnsz;
%         r = r  / (10 * freq(i));
%         l = plot(edges(1 : end - 1), r, 'k-'); pause; delete(l);
%     end
end
xlabel('time (sec)');