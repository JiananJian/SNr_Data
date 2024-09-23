path = '../data'; 
files = ["D1-nZD", "D1-wZD", "GPe-nZD", "GPe-wZD"];    
figure(1); clf; hold on; 
for i = 1 : length(files)
    file = files(i);
    A = readmatrix(fullfile(path, file), 'NumHeaderLines', 1); 
    A(A >= 2) = nan;
    a = A(2 : end, :) - A(1 : end - 1, :);
    subplot(2, 2, i); hold on;
    dx = 2; edges = 0: dx : 200; 
    N = histcounts(a(:), edges * 1e-3);
    h = bar(edges(1 : end - 1), N/sum(N)/dx, 'histc'); h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
    xlabel('isi (ms)'); ylabel('pdf (1/ms)'); title(file); ylim([0, .04]);

    for j = 1 : size(a, 2)
        N0 = histcounts(a(:, j), edges * 1e-3);
        h = plot(edges(1 : end - 1) + dx/2, N0/sum(N)/dx, 'k');% pause; delete(h);
    end
end


%% wZD both GPe and D1
path = '../data'; 
files = ["D1-wZD", "GPe-wZD"];  
N = zeros(2, 100);
figure(2); clf; hold on; 
for i = 1 : length(files)
    file = files(i);
    A = readmatrix(fullfile(path, file), 'NumHeaderLines', 1); 
    A(A >= 2) = nan;
    a = A(2 : end, :) - A(1 : end - 1, :);
    dx = 2; edges = 0: dx : 200; 
    N(i, :) = histcounts(a(:), edges * 1e-3);
end
N = sum(N);
    h = bar(edges(1 : end - 1), N/sum(N)/dx, 'histc'); h.EdgeColor = 'none'; h.FaceColor = "#0072BD";
    xlabel('isi (ms)'); ylabel('pdf (1/ms)'); title('wZD'); ylim([0, .04]);
