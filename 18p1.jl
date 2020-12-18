println(sum(eval.(Meta.parse.(replace.(readlines("18.txt"),"*"=>"|>a->a*")))))
