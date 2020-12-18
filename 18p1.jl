ls = replace.(readlines("18.txt"), "*" => "|> a -> a *")
println("Part 1: ",sum(eval.(Meta.parse.(ls))))
