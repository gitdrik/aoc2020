function key()
    n, key = 1, 1
    while n != 5290733
        n = n * 7 % 20201227
        key = key * 15231938 % 20201227
    end
    return key
end
println("Day 25: ", key())
