open("05.txt") do f
    IDs = BitSet() # a sorted set
    for l in eachline(f)
        ID = replace(l, r"F|L"=>'0') |>
             l->replace(l, r"B|R"=>'1') |>
             l->parse(Int, l, base=2)
        push!(IDs, ID)
    end
    largest = pop!(IDs)
    println("Part 1: ", largest)
    while true
        nextlargest = pop!(IDs)
        largest-nextlargest > 1 ? break : largest = nextlargest
    end
    println("Part 2: ", largest-1)
end
