using DataStructures
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

    ais = SortedDict{String,String}()
    while length(ad) > 0
        nais = Dict([(a,pop!(is)) for (a,is) ∈ ad if length(is)==1])
        for (a,i) ∈ nais
            delete!(ad, a)
            for (aa, ii) ∈ ad
                delete!(ad[aa],i)
            end
        end
        ais = merge(ais, nais)
    end
    println("Part 2: ", join([i for (a,i) ∈ ais],','))
end
