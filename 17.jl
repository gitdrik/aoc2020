open("17.txt") do f
    pocket3D = BitArray(zeros(22,22,15))
    pocket4D = BitArray(zeros(22,22,15,15))
    for (i,l) in enumerate(eachline(f))
        pocket3D[8:15,i+7,8] = [c=='#' for c in l]
        pocket4D[8:15,i+7,8,8] = [c=='#' for c in l]
    end

    function cycle3D(pocket, n)
        xr, yr, zr = 8:15, 8:15, 8:8
        for c ∈ 1:n
            updates = []
            xr = xr.start-1:xr.stop+1
            yr = yr.start-1:yr.stop+1
            zr = zr.start-1:zr.stop+1
            for x ∈ xr, y ∈ yr, z ∈ zr
                neighbors = sum([pocket[nx,ny,nz] for nx ∈ x-1:x+1
                                                  for ny ∈ y-1:y+1
                                                  for nz ∈ z-1:z+1
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
        xr, yr, zr, wr = 8:15, 8:15, 8:8, 8:8
        for c ∈ 1:n
            updates = []
            xr = xr.start-1:xr.stop+1
            yr = yr.start-1:yr.stop+1
            zr = zr.start-1:zr.stop+1
            wr = wr.start-1:wr.stop+1
            for x ∈ xr, y ∈ yr, z ∈ zr, w ∈ wr
                neighbors = sum([pocket[nx,ny,nz,nw] for nx ∈ x-1:x+1
                                                     for ny ∈ y-1:y+1
                                                     for nz ∈ z-1:z+1
                                                     for nw ∈ w-1:w+1
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
