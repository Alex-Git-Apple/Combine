//: [Previous](@previous)

import Foundation
import Combine

// MARK: Use Futurn and Promise to convert completion to Publisher

func verifyUser(_ completion: (String, String) -> Void, errorBlock: (Error) -> Void) {
    completion("Alex", "100")
}

func verifyUser() -> Future<(String, String), Error> {
    Future { promise in
        verifyUser { username, userid in
            promise(.success((username, userid)))
        } errorBlock: { error in
            promise(.failure(error))
        }
    }
}

let sub = verifyUser().sink { _ in
} receiveValue: { (username, userid) in
    print("\(username) --- \(userid)")
}


// MARK: Convert completion to AnyPublisher

struct User: Codable {
    var username: String
    var userid: String
}

func getSearchTweets(sucessBlock: (Data?, URLResponse?) -> Void, errorBlock: (Error) -> Void) {
    let user1 = User(username: "Alex", userid: "1")
    let user2 = User(username: "Bol", userid: "2")
    let data = try? JSONEncoder().encode([user1, user2])
//    sucessBlock(data, nil)
    errorBlock(URLError(.badURL))
}

func getSearchTweets() -> AnyPublisher<[User], Error> {
    Future { promise in
        getSearchTweets { data, response in
            promise(.success(data))
        } errorBlock: { error in
            promise(.failure(error))
        }
    }
    .compactMap { $0 }
    .decode(type: [User].self, decoder: JSONDecoder())
    .eraseToAnyPublisher()
}

let sub2 = getSearchTweets().sink { completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(let error):
        print("\(error)")
    }
} receiveValue: { users in
    print(users)
}


//: [Next](@next)
