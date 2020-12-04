open("04.txt") do f
    ps = read(f, String) |> strip |> s->split(s,"\n\n") |>
         ss->[split(s,[' ','\n']) for s in ss] |>
         ss->[Dict(split.(s,':')) for s in ss]
    req = Set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
    println("Part 1: ", sum([setdiff(req, keys(p)) == Set() for p in ps]))

    p2 = 0
    for p in ps
        if setdiff(req, keys(p)) == Set()
            p2 += (parse(Int,p["byr"]) in 1920:2002) &&
                  (parse(Int,p["iyr"]) in 2010:2020) &&
                  (parse(Int,p["eyr"]) in 2020:2030) &&
                  (p["hgt"][end-1:end]=="cm" && (parse(Int,p["hgt"][1:end-2]) in 150:193) ||
                   p["hgt"][end-1:end]=="in" && (parse(Int,p["hgt"][1:end-2]) in 59:76)) &&
                  (length(p["hcl"]) == 7) &&
                  (p["hcl"][1] == '#') &&
                  (prod([c in "0123456789abcdef" for c in p["hcl"][2:7]])) &&
                  (p["ecl"] in ["amb","blu","brn","gry","grn","hzl","oth"]) &&
                  (length(p["pid"]) == 9) &&
                  (prod([c in "0123456789" for c in p["pid"]]))
        end
    end
    println("Part 2: ", p2)
end
