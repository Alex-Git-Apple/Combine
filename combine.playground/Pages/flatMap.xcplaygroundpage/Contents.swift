//: [Previous](@previous)

import UIKit
import Combine

// flatMap try to execute concurrently.
// maxPublishers: Specifies the maximum number of concurrent publisher subscriptions, or unlimited if unspecified.
// Use buffer to prevent data lose.

class ImageFetcher {
    
    @Published var images = [UIImage]()
    
    let urlStringSubject = CurrentValueSubject<String, Never>("")
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        urlStringSubject
            .compactMap {  URL(string: $0) }
            .flatMap { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .compactMap {
                        UIImage(data: $0)
                    }
//                    .catch { _ in
//                        Empty()
//                    }
            }
            .scan([UIImage](), { all, next in
                all + [next]
            })
            .sink { _ in
            } receiveValue: { [unowned self] image in
                self.images = images
            }
            .store(in: &subscriptions)

    }
}

//: [Next](@next)
