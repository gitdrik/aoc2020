open("17.txt") do f
    pocket3D = BitArray(zeros(20,20,13))
    pocket4D = BitArray(zeros(20,20,13,13))
    for (i,l) in enumerate(eachline(f))
        pocket3D[7:14,i+6,7] = [c=='#' for c in l]
        pocket4D[7:14,i+6,7,7] = [c=='#' for c in l]
    end

    function cycle3D(pocket, n)
        xs, ys, zs = size(pocket)
        for c ∈ 1:n
            updates = []
            for x ∈ 1:xs, y ∈ 1:ys, z ∈ 1:zs
                neighbors = sum([pocket[nx,ny,nz] for nx ∈ max(1,x-1):min(xs,x+1)
                                                  for ny ∈ max(1,y-1):min(ys,y+1)
                                                  for nz ∈ max(1,z-1):min(zs,z+1)
                                                         if (nx,ny,nz) != (x,y,z)])
                if pocket[x,y,z]==1 && neighbors ∉ [2,3]
                    push!(updates, [x,y,z,0])
                elseif neighbors==3 && pocket[x,y,z]==0
                    push!(updates, [x,y,z,1])
                end
            end
            for (x,y,z,b) in updates
                pocket[x,y,z] = b
            end
        end
        return pocket
    end

    function cycle4D(pocket, n)
        xs, ys, zs, ws = size(pocket)
        for c ∈ 1:n
            updates = []
            for x ∈ 1:xs, y ∈ 1:ys, z ∈ 1:zs, w ∈ 1:ws
                neighbors = sum([pocket[nx,ny,nz,nw] for nx ∈ max(1,x-1):min(xs,x+1)
                                                     for ny ∈ max(1,y-1):min(ys,y+1)
                                                     for nz ∈ max(1,z-1):min(zs,z+1)
                                                     for nw ∈ max(1,w-1):min(ws,w+1)
                                                       if (nx,ny,nz,nw) != (x,y,z,w)])
                if pocket[x,y,z,w]==1 && neighbors ∉ [2,3]
                    push!(updates, [x,y,z,w,0])
                elseif neighbors==3 && pocket[x,y,z,w]==0
                    push!(updates, [x,y,z,w,1])
                end
            end
            for (x,y,z,w,b) in updates
                pocket[x,y,z,w] = b
            end
        end
        return pocket
    end
    println("Part 1: ", sum(cycle3D(pocket3D,6)))
    println("Part 2: ", sum(cycle4D(pocket4D,6)))
end
