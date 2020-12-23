function p1()
    ns = [1,5,8,9,3,7,4,6,2]
    for i ∈ 1:100
        dl = mod(ns[1]-2,9)+1
        while dl ∈ ns[2:4]
            dl = mod(dl-2,9)+1
        end
        di = findfirst(isequal(dl),ns)
        ns = [ns[5:di];ns[2:4];ns[di+1:end];ns[1:1]]
    end
    ns = circshift(ns,-findfirst(isequal(1),ns))[1:end-1]
    return join(string.(ns))
end
println("Part 1: ", p1())

function p2()
    # ns = [1,5,8,9,3,7,4,6,2]
    # rephrase as forward linked list, with "label" as the list position.
    ll = [[5,10,7,6,8,2,4,9,3];collect(11:1000000);[1]]
    c0, llen = 1, length(ll)
    for n ∈ 1:10000000
        # pick three
        c1 = ll[c0]
        c2 = ll[c1]
        c3 = ll[c2]
        # stich list together
        ll[c0] = ll[c3]
        # find insertion label
        i = mod(c0-2, llen) + 1
        while i ∈ [c1,c2,c3]
            i = mod(i-2, llen) + 1
        end
        # new current
        c0 = ll[c3]
        # insert the three
        ll[c3] = ll[i]
        ll[i] = c1
    end
    return ll[1]*ll[ll[1]]
end
println("Part 2: ",p2())
