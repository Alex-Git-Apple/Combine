//: [Previous](@previous)

import Foundation

// publisher that will pass a limited number of values

let footbank = ["apple", "bread", "orange", "milk"].publisher

//let sub = footbank.sink { completion in
//    print("completion: \(completion)")
//} receiveValue: { food in
//    print("received \(food)")
//}

let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: Date())!

struct MyError: Error {
    
}

func throwAtEndDate(foodItem: String, date: Date) throws -> String {
    if date < endDate {
        return "\(foodItem) at \(date)"
    } else {
        throw MyError()
    }
}
    

let sub2 = footbank
    .zip(timer)
    .tryMap({ (foodItem, timestamp) in
        try throwAtEndDate(foodItem: foodItem, date: timestamp)
    })
    .sink { completion in
        switch completion {
        case .finished:
            print("completion: \(completion)")
        case .failure(let error):
            print("failiure: \(error)")
        }
        
    } receiveValue: { food in
        print("received \(food)")
    }


//: [Next](@next)
