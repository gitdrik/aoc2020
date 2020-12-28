open("19.txt") do f
    ls = replace.(readlines(f), '"'=>"")
    rules::Dict{String,Array{String}} =
        Dict([s[1][1:end-1]=>s[2:end] for s in split.(ls[1:137])])

    rparse(rules, key) = key ∉ keys(rules) ? key :
        join([["("];[rparse(rules,r) for r in rules[key]];[")"]])

    p1 = sum(occursin.(Regex('^'*rparse(rules,"0")*'$'),ls[139:end]))
    println("Part 1: ",p1)

    r42, r31 = rparse(rules, "42"), rparse(rules, "31")
    p2 = sum(occursin.(Regex('^'*r42*"+(?<r>"*r42*"(?&r)?"*r31*")\$"),ls[139:end]))
    println("Part 2: ", p2)
end
