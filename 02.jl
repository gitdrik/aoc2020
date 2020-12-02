open("02.txt") do f
    p1, p2 = 0, 0
    for l in eachline(f)
        ss = split(l,' ')
        min, max = parse.(Int, split(ss[1], '-'))
        ltr = ss[2][1]
        pwd = ss[3]
        n = sum([c==ltr for c in pwd])
        p1 += n in min:max
        p2 += xor(pwd[min]==ltr, pwd[max]==ltr)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end
