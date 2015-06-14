function cost = splitterCost(NewST)
        
    % compute connection qty of each node
    nodeSplitQty = sum(NewST,2)/2;

    % find idx of nodes with connection qty > 1
    nodeSplitIdx = nodeSplitQty > 1;

    % compute splitter cost on each node (with more than 1 connection)
    nodeSplitCost = 10 ./(1+exp(-nodeSplitQty(nodeSplitIdx) ./10));

    cost = sum(nodeSplitCost);

end