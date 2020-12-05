open("05.txt") do f
    maxID, IDs = 0, []
    for l in eachline(f)
        l = replace(l, r"F|L"=>'0')
        l = replace(l, r"B|R"=>'1')
        ID = parse(Int, l, base=2)
        maxID = max(ID, maxID)
        push!(IDs, ID)
    end
    println("Part 1: ", maxID)
    sort!(IDs)
    for i in 2:length(IDs)
        if IDs[i]-IDs[i-1] > 1
            println("Part 2: ", IDs[i]-1)
            break
        end
    end
end
