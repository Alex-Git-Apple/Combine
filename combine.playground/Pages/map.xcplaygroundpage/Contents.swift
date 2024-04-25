//: [Previous](@previous)

import Foundation
import Combine

struct Quote: Codable {
    var quoteString: String
}

class QuoteFetcher: ObservableObject {
    
    let fileNames = ["quote1", "quote2", "quote3"]
    
    @Published var quotes = [String]()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // load files
        
        fileNames.publisher
            .compactMap { fileName -> URL? in
                Bundle.main.url(forResource: fileName, withExtension: "json")
            }
            .tryMap { url -> Data in
                try Data(contentsOf: url)
            }
            .decode(type: Quote.self, decoder: JSONDecoder())
            .map(\.quoteString)
            .sink { completion in
                print()
            } receiveValue: { [unowned self] quote in
                quotes.append(quote)
            }
    }
}

//: [Next](@next)
