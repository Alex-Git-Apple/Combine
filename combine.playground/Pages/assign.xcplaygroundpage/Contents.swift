//: [Previous](@previous)

import Foundation

class MyClass {
    var anInt = 0 {
        didSet {
            print("anInt was set to \(anInt)")
        }
    }
}

var myObject = MyClass()
let myRange = (0...2)
let sub = myRange.publisher
    .map { $0 * 10 }
// assign to holds strong reference.
    .assign(to: \.anInt, on: myObject)
//    .sink { value in
//        myObject.anInt = value
//    }

//: [Next](@next)
