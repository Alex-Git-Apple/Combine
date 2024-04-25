//: [Previous](@previous)

import Foundation

let range = (0...5)
var sub1 = range.publisher
    .scan(0) { return $0 + $1 }
    .sink { print ("\($0)", terminator: " ") }


let sub2 = range.publisher
    .reduce(0) { accumulatedValue, newValue in
        return accumulatedValue + newValue
    }
    .sink { print($0) }


//: [Next](@next)
