module ExpEval
    
    using DelimitedFiles
    using DataFrames
    using Distances
    

    
    export LoadDataSumary,
           LoadDataBase,
           calculate_distance_matrices_euc,
           calculate_distance_matrices_dtw
    
    include("UCR_archive_utils.jl")
    include("distance_matrices.jl")

end
