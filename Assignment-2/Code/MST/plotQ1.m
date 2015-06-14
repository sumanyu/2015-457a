clc, clear, close;
set(0,'DefaultFigureWindowStyle','docked');
addpath(genpath(pwd));

%load results
load('results.mat')
a_b = [results{1,3}{1:5,4}];
c = [results{2,3}{1:5,4}];
d_1 = [results{3,3}{1:5,4}];
d_2 = [results{4,3}{1:5,4}];

sCost = [a_b; c; d_1; d_2]+2;

bar(sCost);
title('Tabu search (# of iter: 200)', 'FontSize', 18);
ylabel('Avg solution cost')
legend('TabuLength: 5','TabuLength: 10','TabuLength: 15','TabuLength: 25','TabuLength: 50','Location','SouthEast');
set(gca,'XtickLabel', {'A & B', 'C (aspiration)', 'D (splitter)', 'D (aspiration + splitter)'}, 'fontsize',12);
saveas(gcf, 'tabu_results', 'fig');
saveas(gcf, 'tabu_results', 'png');

%clean memory & path
rmpath(genpath(pwd));