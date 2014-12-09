

var evens = [Int]()

for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0

for i in evens {
    evenSum += i
}

println(evenSum)
