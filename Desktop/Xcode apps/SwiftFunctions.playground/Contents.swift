var myArray = [ [1, 2, 3],
                [2, 4, 8],
                [9, 1, 7],
                [4, 3, 6],
                [6, 1, 4]]

print(myArray.sorted(by: { (x:[Int], y:[Int]) -> Bool in
    return x[2] > y[2]
} ))
