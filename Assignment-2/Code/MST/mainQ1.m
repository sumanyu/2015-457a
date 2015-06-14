clc, clear, close;
set(0,'DefaultFigureWindowStyle','docked');
addpath(genpath(pwd));

% load data
load('Units100.mat')

% %tests to find the best number of iterations
% NumIterations = [50 100 150 200 250 300];
% costIter = zeros(length(NumIterations),1);
% for idx=1:length(NumIterations)
%                
%     [BestSoln, bestCost] = TabuSearch(Graph, 10, ...
%                                       NumIterations(idx), @GenInitialST, @GetBestNeighbourST_splitterAdded);
%     costIter(idx) = mean(bestCost);
%     fprintf('trial:%d cost:%f \n', idx, costIter(idx));
%     
% end

% set timer

% tabu each neighbourhood function
NumIterations = 200;
fnList = {@GetBestNeighbourST, @GetBestNeighbourST_aspirationAdded, @GetBestNeighbourST_splitterAdded, @GetBestNeighbourST_aspirationSplitterAdded};
results = cell(length(fnList),3);
for fn=1:length(fnList);
    
    tic;
    
    % for each tabu length
    TabuLength = [5 10 15 25 50];
    fnResults = [cell(length(TabuLength),4); {'Tabu length', 'Number of iterations', 'Running time', 'Solution cost'}];
    for tabuLen=1:length(TabuLength)

        %run tabu search five times
        bestCost = zeros(4,1);
        for trial=1:length(bestCost)
            
            [BestSoln, bestCost(trial)] = TabuSearch(Graph, TabuLength(tabuLen), ...
                                                        NumIterations, @GenInitialST, fnList{fn});
            
            fprintf('fn:%d length:%d trial:%d \n', fn, tabuLen, trial);
            toc
            
        end

        %store results
        fnResults{tabuLen, 1} = TabuLength(tabuLen);
        fnResults{tabuLen, 2} = NumIterations;
        fnResults{tabuLen, 3} = toc;
        fnResults{tabuLen, 4} = mean(bestCost);

    end
    results{fn,1} = fnList{fn};
    results{fn,2} = toc;
    results{fn,3} = fnResults;
    
end

% krukal algorithm
[MST, MSTCost] = Kruskal(Graph);
MSTCost_splitter = MSTCost + splitterCost(MST);
resultsKruskal = {MSTCost, MSTCost_splitter, 'kruskal', 'kruskal (splitter cost added)'};

%clean memory & path
rmpath(genpath(pwd));
clearvars -except results resultsKruskal
save('results');