filename = ["D1-nZD", "D1-wZD", "GPe-nZD", "GPe-wZD"];
LineSpec = ["or", "or", "ob", "ob"];
MarkerFaceColor = ["r", "none", "b", "none"];
N = cell(4, 1); 

figure(5); clf;
for i = 1 : 4
    subplot(2, 2, i); N{i} = plot1(filename(i), LineSpec(i), MarkerFaceColor(i));
end

%%
figure(6); clf; hold on;
for i = 1 : 4
    n = size(N{i}, 1);
    plot((1 : n) / n, sort(N{i}(:, 2) ./ N{i}(:, 1)), "-" + LineSpec(i), 'MarkerSize', 4, 'MarkerFaceColor', MarkerFaceColor(i));
end
ylabel('optostim rate / baseline rate'); xticks({}); xlabel('cells');
legend(filename, 'location', 'northwest');

figure(7); clf; hold on;
for i = 1 : 4
    I = (N{i}(:, 2) > 0);
    plot((1 : sum(I)) / sum(I), sort(N{i}(I, 2) ./ N{i}(I, 1)), "-" + LineSpec(i), 'MarkerSize', 4, 'MarkerFaceColor', MarkerFaceColor(i));
end
ylabel('optostim rate / baseline rate'); xticks({}); xlabel('cells - excluding completely inhited cells');
legend(filename, 'location', 'northwest');

%%
figure(8); clf; hold on;
X = zeros(4, 4);
for i = 1 : 4
    r = N{i}(:, 2) ./ N{i}(:, 1); X(i, :) = [sum(r == 0), sum(r > 0 & r < 1), sum(r == 1), sum(r > 1)] / size(N{i}, 1);
end
b = bar(1 : 4, X, "stacked");
xlim([0, 6]); xticks(1 : 4); xticklabels(filename); 
legend("-100%", "dec.", "n.c.", "inc."); title('rate change');

%% baseline
nZD = sort([N{1}(:, 1); N{3}(:, 1)]);
wZD = sort([N{2}(:, 1); N{4}(:, 1)]);

color = '#0072BD';
figure(9); clf; hold on;
plot(nZD, '-o', 'Color', color, 'MarkerSize', 4, 'MarkerFaceColor', color); 
plot(wZD, '-o', 'Color', color, 'MarkerSize', 4, 'MarkerFaceColor', 'none');
ylabel('baseline rate (Hz)'); xlabel('count'); 
legend('nZD', 'wZD', 'Location', 'northwest');

figure(19); clf; hold on;
n1 = length(nZD);
n2 = length(wZD);
plot((1 : n1) / n1, nZD, '-o', 'Color', color, 'MarkerSize', 4, 'MarkerFaceColor', color); 
plot((1 : n2) / n2, wZD, '-o', 'Color', color, 'MarkerSize', 4, 'MarkerFaceColor', 'none');
ylabel('baseline rate (Hz)'); xlabel('percentage'); 
legend('nZD', 'wZD', 'Location', 'northwest');

% baseline eCDF
figure(28); clf; hold on;
stairs([0; wZD], (0 : n2) / n2, '-', 'Color', 'r', 'MarkerSize', 4, 'MarkerFaceColor', 'none');
stairs([0; nZD], (0 : n1) / n1, '-', 'Color', 'b', 'MarkerSize', 4, 'MarkerFaceColor', color); 
legend('wZD', 'nZD', 'Location', 'northwest');
xlabel('baseline rate (Hz)'); ylabel('eCDF'); xlim([0, 80]);

figure(29); clf; hold on;
ax1 = gca; ax1.XColor = 'b'; ax1_pos = get(ax1, 'Position'); % Get the position of the first axes
plot(0, 0, 'r'); 
stairs(ax1, [0; nZD], (0 : n1) / n1, '-', 'Color', 'b', 'MarkerSize', 4, 'MarkerFaceColor', color); 
legend('wZD', 'nZD', 'Location', 'northwest');
xlabel('baseline rate (Hz)', 'Color', [0.15 0.15 0.15]); ylabel('eCDF'); 
xlim([0, 80]);

% KS-test
r = 0.68; [h, p, ks2stat] = kstest2(nZD * r, wZD);

% Create a secondary axes positioned on top of the first one
ax2 = axes('Position', ax1_pos, 'Color', 'none'); % 'Color', 'none' makes the axes background transparent
ax2.XAxisLocation = 'top'; % Set the x-axis location to top
ax2.XColor = 'r';
% Plot on the second axes
hold(ax2, 'on');
stairs(ax2, [0; wZD], (0 : n2) / n2, '-', 'Color', 'r', 'MarkerSize', 4, 'MarkerFaceColor', 'none');
xlim([0, 80 * r]);

% wZD rates vs nZD rates
figure(30); clf; hold on;
stairs(wZD, nZD(ceil((1 : n2) * n1 / n2)),'k');
stairs(wZD(ceil((1 : n1) * n2 / n1)), nZD,'k');
plot([0, 80], [0, 80], 'k:');
plot([0, 80] * r, [0, 80], 'k--');
xlabel('wZD rate (Hz)'); ylabel('nZD rate (Hz)');

% %%
% figure(9); clf; hold on;
% p = 1 : length(wZD);
% histogram(wZD, 0 : 60);

% figure(9); clf; hold on;
% plot(M(:,4), M(:,2));
% xlabel('baseline rate (Hz)'); ylabel('g_{HCN} (nS/pF)');
% xlim([0, max(M(:,4))]);


%% baseline
color = '#0072BD';

a = (1 : n1)' / n1; N1 = [N{1}(:, 1); N{3}(:, 1)]; [nZD, I] = sort(N1);
i = (I <= size(N{1}, 1)); j = (I > size(N{1}, 1));
figure(9); clf; hold on;
plot(a, nZD, '-', 'Color', color, 'MarkerSize', 4, 'MarkerFaceColor', color); 
plot(a(i), N1(I(i)), 'o', 'Color', 'r', 'MarkerSize', 4, 'MarkerFaceColor', 'r'); 
plot(a(j), N1(I(j)), 'o', 'Color', 'b', 'MarkerSize', 4, 'MarkerFaceColor', 'b'); 

a = (1 : n2)' / n2; N2 = [N{2}(:, 1); N{4}(:, 1)]; [wZD, I] = sort(N2);
i = (I <= size(N{2}, 1)); j = (I > size(N{2}, 1));
plot(a, wZD, '-', 'Color', color, 'MarkerSize', 4, 'MarkerFaceColor', 'none');
plot(a(i), N2(I(i)), 'o', 'Color', 'r', 'MarkerSize', 4, 'MarkerFaceColor', 'none'); 
plot(a(j), N2(I(j)), 'o', 'Color', 'b', 'MarkerSize', 4, 'MarkerFaceColor', 'none'); 
ylabel('baseline rate (Hz)'); xlabel('count'); 
legend('','nZD','','','wZD', 'Location', 'northwest');
    
function N = plot1(filename, LineSpec, MarkerFaceColor)
    path = '../data'; 
    A = readmatrix(fullfile(path, filename), 'NumHeaderLines', 1); 
    n = size(A, 2); N = zeros(n, 2);
    edges = [1, 2, 3]; bnsz = edges(2 : end) - edges(1 : end - 1);
    for i = 1 : n
        N(i, :) = histcounts(A(:, i), edges) ./ bnsz; 
    end
    cla; hold on;
    plot([0, 80], [0, 80], 'k');
    plot(N(:, 1), N(:, 2), LineSpec, 'MarkerSize', 4, 'MarkerFaceColor', MarkerFaceColor); 
    title(filename); xlabel('baseline rate (Hz)'); ylabel('optostim rate (Hz)')
end
