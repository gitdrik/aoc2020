open("04.txt") do f
    ps = read(f, String) |> strip |> s->split(s,"\n\n") .|>
         s -> split(s,[' ','\n']) |> s-> Dict(split.(s,':'))
    req = Set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
    println("Part 1: ", sum([req ⊆ keys(p) for p ∈ ps]))
    println("Part 2: ", sum([
        req ⊆ keys(p) &&
        (parse(Int,p["byr"]) ∈ 1920:2002) &&
        (parse(Int,p["iyr"]) ∈ 2010:2020) &&
        (parse(Int,p["eyr"]) ∈ 2020:2030) &&
        (p["hgt"][end-1:end]=="cm" && (parse(Int,p["hgt"][1:end-2]) ∈ 150:193) ||
        p["hgt"][end-1:end]=="in" && (parse(Int,p["hgt"][1:end-2]) ∈ 59:76)) &&
        (length(p["hcl"]) == 7) &&
        (p["hcl"][1] == '#') &&
        (prod([c ∈ "0123456789abcdef" for c ∈ p["hcl"][2:7]])) &&
        (p["ecl"] ∈ ["amb","blu","brn","gry","grn","hzl","oth"]) &&
        (length(p["pid"]) == 9) &&
        (prod([c ∈ '0':'9' for c ∈ p["pid"]])) for p ∈ ps]))
end
