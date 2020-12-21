open("21.txt") do f
    labels = []
    ad = Dict{String, Set{String}}()
    for l ∈ eachline(f)
        is, as = split(l," (contains ")
        is, as = split(is), split(as[1:end-1],", ")
        push!(labels, [is, as])
        for a ∈ as
            ad[a] = get(ad, a, Set(is)) ∩ Set(is)
        end
    end

    maybeallergenic = Set(vcat(collect.(values(ad))...))
    p1 = sum([length(setdiff(Set(is), maybeallergenic)) for (is, as) ∈ labels])
    println("Part 1: ", p1)

    # Make list by eyeballing println(ad)
    ais = [("dairy","vcckp"),
           ("eggs","hjz"),
           ("fish","nhvprqb"),
           ("nuts","jhtfzk"),
           ("peanuts","mgkhhc"),
           ("sesame","qbgbmc"),
           ("shellfish","bzcrknb"),
           ("wheat","zmh")]
    println("Part 2: ", join([i for (a,i) ∈ ais],","))
end
