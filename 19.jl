open("19.txt") do f
    ls = readlines(f)
    rules::Dict{String,Array{String}} =
        Dict([s[1][1:end-1]=>s[2:end] for s in split.(ls[1:137])])

    function rparse(rules, key)
        r = rules[key]
        if r[1][1] == '"'
            return r[1][2]
        elseif length(r) ∈ 1:2
            return string([rparse(rules, k) for k in r]...)
        elseif length(r) == 3
            return '('*rparse(rules, r[1])*'|'*rparse(rules, r[3])*')'
        else
            return '('*rparse(rules, r[1])*rparse(rules, r[2])*'|'*
                       rparse(rules, r[4])*rparse(rules, r[5])*')'
        end
    end

    p1 = 0
    for s ∈ ls[139:end]
        m = match(Regex(rparse(rules,"0")),s)
        if m != nothing
            p1 += m.match == s
        end
    end
    println("Part 1: ",p1)

    p2 = 0
    for s ∈ ls[139:end]
        r42, r31 = rparse(rules, "42"), rparse(rules, "31")
        n42, n31 = 0, 0
        while length(s) > 0
            ns = replace(s, Regex(r42)=>"c",count=1)
            if ns[1] == 'c'
                n42 += 1
                s = ns[2:end]
            else
                break
            end
        end
        while length(s) > 0
            ns = replace(s, Regex(r31)=>"c",count=1)
            if ns[1] == 'c'
                n31 += 1
                s = ns[2:end]
            else
                break
            end
        end
        p2 += length(s)==0 && n42 > 1 && n42 > n31 > 0
    end
    println("Part 2: ",p2)
end
