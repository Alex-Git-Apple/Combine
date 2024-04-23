//: [Previous](@previous)

import Foundation
import Combine

let newUserNameEntered = PassthroughSubject<String, Never>()


let sub = newUserNameEntered.sink {
    print ("completion \($0)")
} receiveValue: { value in
    print("receive value: \(value)")
}

newUserNameEntered.send("Bob")
newUserNameEntered.send(completion: .finished)


// Use eraseToAnyPublisher() to prevent caller modifying the publisher

class ViewModel {
    
    private let usernameSubject = CurrentValueSubject<String, Never>("Alex")
    public let username: AnyPublisher<String, Never>
    
    init() {
        username = usernameSubject.eraseToAnyPublisher()
    }
}

//: [Next](@next)
