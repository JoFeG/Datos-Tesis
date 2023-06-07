function calculate_distance_matrices_euc(
        ID::Int, 
        DataSumary_df::DataFrame, 
        rewrite::Bool = true
    )
    
    dataset = DataSumary_df[DataSumary_df.ID .== ID, :]
    
    TEST, TEST_labels, TRAIN, TRAIN_labels = LoadDataBase(ID, DataSumary_df)

    TRAIN_dist_mat_euc = Distances.pairwise(Distances.Euclidean(), TRAIN, TRAIN, dims=1)
    TEST_dist_mat_euc = Distances.pairwise(Distances.Euclidean(), TEST, TEST, dims=1)
    
    if rewrite
        writedlm("./UCRArchive_2018/" * dataset.Name[] * "/" * "TRAIN_dist_mat_euc.csv",  TRAIN_dist_mat_euc, ',')
        writedlm("./UCRArchive_2018/" * dataset.Name[] * "/" * "TEST_dist_mat_euc.csv",  TRAIN_dist_mat_euc, ',')
    end
    
    return TRAIN_dist_mat_euc, TEST_dist_mat_euc
end

#### REVISAR ESTA IMPLEMENTACION DE DTW !!! (Y ALTERNATIVAS EN EL MISMO PAQUETE)
#### TIRA WARNINGS POR EL PyPlot QUE YA NO SIGUE EN JULIA... OTROS PROBLEMAS?
import TimeWarp as tw

function calculate_distance_matrices_dtw(
        ID::Int, 
        DataSumary_df::DataFrame, 
        rewrite::Bool = true
    )

    dataset = DataSumary_df[DataSumary_df.ID .== ID, :]
    
    TEST, TEST_labels, TRAIN, TRAIN_labels = LoadDataBase(ID, DataSumary_df)

    n_TR = dataset.Train[] 
    TRAIN_dist_mat_dtw = zeros(n_TR, n_TR)
    for i = 1:n_TR
        for j = 1:n_TR
            TRAIN_dist_mat_dtw[i,j] = tw.dtw(TRAIN[i,:], TRAIN[j,:])[1]
        end
    end
    
    n_TE = dataset.Test[]
    TEST_dist_mat_dtw = zeros(n_TE, n_TE)
    for i = 1:n_TE
        for j = 1:n_TE
            TEST_dist_mat_dtw[i,j] = tw.dtw(TEST[i,:], TEST[j,:])[1]
        end
    end
    
    if rewrite
        writedlm("./UCRArchive_2018/" * dataset.Name[] * "/" * "TRAIN_dist_mat_dtw.csv",  TRAIN_dist_mat_dtw, ',')
        writedlm("./UCRArchive_2018/" * dataset.Name[] * "/" * "TEST_dist_mat_dtw.csv",  TRAIN_dist_mat_dtw, ',')
    end
    
    return TRAIN_dist_mat_dtw, TEST_dist_mat_dtw
end
