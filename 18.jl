open("18.txt") do f
    ls = readlines(f)
    function p1(s)
        if s[end] == ')'
            depth, ps, s = 1, "", s[1:end-1]
            while depth > 0
                ps, s = s[end:end]*ps, s[1:end-1]
                if ps[1] == '('
                    depth -= 1
                elseif ps[1] == ')'
                    depth += 1
                end
            end
            n = p1(ps[2:end])
        else
            n = parse(Int,s[end])
            s = s[1:end-1]
        end
        if length(s)==0
            return n
        elseif s[end-2:end] == " + "
            return p1(s[1:end-3]) + n
        end
        return p1(s[1:end-3]) * n
    end
    println("Part 1: ", sum(p1.(ls)))

    function p2(s, sm)
        if s[1] == '('
            depth, ps, s = 1, "", s[2:end]
            while depth > 0
                ps, s = ps*s[1:1], s[2:end]
                if ps[end] == ')'
                    depth -= 1
                elseif ps[end] == '('
                    depth += 1
                end
            end
            n = p2(ps[1:end-1],0)
        else
            n = parse(Int, s[1])
            s = s[2:end]
        end
        if length(s) == 0
            return n+sm
        elseif s[1:3] == " * "
            return (n+sm) * p2(s[4:end], 0)
        end
        return p2(s[4:end], n+sm)
    end
    println("Part 2: ", sum(p2.(ls,0)))
end
