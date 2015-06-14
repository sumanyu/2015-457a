function bool = isAspirating(NewSTCost, BestNeighbourSTCost, TabuTenure, TabuLength)

    bool = 0;

    if  (NewSTCost < BestNeighbourSTCost && TabuTenure < TabuLength/5)
        bool = 1;
    end

end