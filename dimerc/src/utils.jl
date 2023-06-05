function jsonpoints2arrays(points::JSON3.Array,include_time=false)
    m = length(points)    
    
    x = [points[k].x for k in 1:m]
    y = [points[k].y for k in 1:m]
    
    if include_time        
        t = [points[k].date for k in 1:m]
        return x, y, t
    end
    
    return x, y
end


function seriesjson2matrix(points::JSON3.Array)
    # Constructs a matrix Y of (m × n) with series in the columns and 0s replaced over gaps.
    
    n = length(json)
    series = []
    xs = []
    for k = 1:n
        x, y = jsonpoints2arrays(json[k].points)

        series = [series..., y]
        xs = [xs..., x]
    end
    max_x = maximum(maximum.(xs))
    min_x = minimum(minimum.(xs))
    println("min_x = ", min_x)
    println("max_x = ", max_x)
    m = max_x - min_x

    Y = zeros(m,n)

    for k = 1:n
        for i = 1:m
            #println("k=",k,", i=",i)
            data = series[k][xs[k].==min_x+i-1]
            if length(data)>0
                Y[i,k] = data[1]
            else
                Y[i,k] = 0
            end
        end
    end
    
    return Y, min_x
end


using Statistics: mean
function moving_average(y, hw)
    m = length(y)
    ŷ = zeros(m)
    for t = 1:m
        if t < hw
            ŷ[t] = mean(@view y[1:t])
        elseif t > m-hw
            ŷ[t] = mean(@view y[t:end])
        else
            ŷ[t] = mean(@view y[t-hw+1:t+hw])
        end
    end
    
    return ŷ
end

function exponential_smoothing(y, α)
    m = length(y)
    ŷ = zeros(m)
    ŷ[1] = y[1]
    for t = 2:m
        ŷ[t] = α*y[t] + (1-α)*ŷ[t-1]
    end
    
    return ŷ
end