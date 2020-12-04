open("04.txt") do f
    has(a) = b -> filter(c -> occursin(a,c),b)
    ps = read(f, String) |> s->split(s,"\n\n")
    ps |>
        has("byr") |> has("iyr") |> has("eyr") |> has("hgt") |> has("hcl") |>
        has("ecl") |> has("pid") |> length |> n->println("Part 1: ",n)
    ps |>
        has(r"byr:(19[2-9][0-9]|200[0-2])") |>
        has(r"iyr:20(1[0-9]|20)") |> has(r"eyr:20(2[0-9]|30)") |>
        has(r"hgt:(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-3])in)") |>
        has(r"hcl:#([0-9]|[a-f]){6}") |>
        has(r"ecl:(amb|blu|brn|gry|grn|hzl|oth)") |>
        has(r"pid:[0-9]{9}") |> length |> n->println("Part 2: ",n)
end
