open("06.txt") do f
    gs = read(f, String) |> strip |> s->split(s,"\n\n")
    p1, p2 = 0, 0
    for g in gs
        p1 += setdiff(Set(g), Set('\n')) |> length
        p2 += [Set(i) for i in split(g, '\n')] |> a->intersect(a...) |> length
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end
