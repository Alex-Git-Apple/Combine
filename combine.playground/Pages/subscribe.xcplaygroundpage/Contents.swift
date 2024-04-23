//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

Just("Some text")
    .handleEvents(receiveRequest: {
        _ in print("Handle Events: \(Thread.isMainThread)")
    })
    // Set where the publisher receive requests.
    .subscribe(on: DispatchQueue.global())   // The first one works
    .subscribe(on: DispatchQueue.main)   // The following are not working
    .receive(on: DispatchQueue.main) // Set the downstream
    .map { _ in
        print("Map: \(Thread.isMainThread)")
    }
    .receive(on: DispatchQueue.global()) // Set the downstream again
    .sink { _ in
        print("Sink: \(Thread.isMainThread)")
    }
    .store(in: &subscriptions)


//: [Next](@next)
