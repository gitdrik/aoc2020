open("06.txt") do f
    gs = read(f, String) |> strip |> s->split(s,"\n\n")
    p1, p2 = 0, 0
    for g ∈ gs
        p1 += filter(c->c!='\n', g) |> Set |> length
        p2 += ∩(Set.(split(g, '\n'))...) |> length
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end
