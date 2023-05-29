function jsonpoints2array(points::JSON3.Array,include_time=false)
    m = length(points)    
    
    x = [points[k].x for k in 1:m]
    y = [points[k].y for k in 1:m]
    
    if include_time        
        t = [points[k].date for k in 1:m]
        return x, y, t
    end
    
    return x, y
end

