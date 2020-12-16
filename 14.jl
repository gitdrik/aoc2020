open("14.txt") do f
    ls = readlines(f)
    mem::Dict{Int,Int} = Dict()
    zeromask = BitArray(ones(36))
    onemask  = BitArray(zeros(36))
    for l ∈ ls
        ss = split(l, " = ")
        if ss[1]=="mask"
            zeromask = BitArray([c!='0' for c in ss[2]])
            onemask  = BitArray([c=='1' for c in ss[2]])
        else
            address = parse(Int, ss[1][5:end-1])
            value   = parse(Int, ss[2]) |> v->digits(v, base=2, pad=36) |> reverse |> BitArray
            value .&= zeromask
            value .|= onemask
            mem[address] = sum(2 .^(35:-1:0) .* value)
        end
    end
    println("Part 1: ", sum(values(mem)))

    mem, xs = Dict(), []
    onemask = BitArray(zeros(36))
    for l ∈ ls
        ss = split(l, " = ")
        if ss[1]=="mask"
            xs = [i for (i, c) in enumerate(ss[2]) if c=='X']
            onemask = BitArray([c=='1' for c in ss[2]])
        else
            value = parse(Int, ss[2])
            address = parse(Int, ss[1][5:end-1]) |> v->digits(v, base=2, pad=36) |> reverse |> BitArray
            address .|= onemask
            for i ∈ 0:(2^length(xs)-1)
                bits = digits(i, base=2, pad=length(xs)) |> reverse |> BitArray
                for (pos,b) ∈ enumerate(bits)
                    address[xs[pos]] = b
                end
                mem[sum(2 .^(35:-1:0) .* address)] = value
            end
        end
    end
    println("Part 2: ", sum(values(mem)))
end
