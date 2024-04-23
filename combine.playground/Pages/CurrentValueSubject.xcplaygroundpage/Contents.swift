//: [Previous](@previous)

import Combine

struct User {
    var id: Int
    var name: String
}

let currentUserID = CurrentValueSubject<Int, Never>(1000)
let currentUser = CurrentValueSubject<User, Never>(User(id: 1, name: "Bob"))

let sub = currentUserID.sink {
    print ("completion \($0)")
} receiveValue: { value in
    print("receive value: \(value)")
}

// passing down new values
currentUserID.send(1)
currentUserID.send(2)

currentUserID.send(completion: .finished)
currentUserID.send(3)

//: [Next](@next)
