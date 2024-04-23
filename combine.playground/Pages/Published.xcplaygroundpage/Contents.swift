//: [Previous](@previous)

import Combine

// When the property changes, publishing ocurrs in the property's `willSet` block, meaning the subscribers receive the new
// value before it's actually set.

class ViewModel {
    
    @Published var usernames = ["Bill"]
    let newUsernameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $usernames.sink { [unowned self] value in
            print("receive value \(value) with \(self.usernames)")
        }.store(in: &subscriptions)
        
        newUsernameEntered.sink { [unowned self] value in
            self.usernames.append(value)
        }.store(in: &subscriptions)
    }
}

let vm = ViewModel()
vm.newUsernameEntered.send("Susan")

//: [Next](@next)
