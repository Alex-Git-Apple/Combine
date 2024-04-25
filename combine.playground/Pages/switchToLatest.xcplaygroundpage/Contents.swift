//: [Previous](@previous)

import UIKit
import Combine

// When this operator receives a new publisher from the upstream publisher, it cancels its previous subscription.

class ImageFetcher {
    
    @Published var image: UIImage? = nil
    
    let urlStringSubject = CurrentValueSubject<String, Never>("")
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        urlStringSubject
            .compactMap { URL(string: $0) }
            .map { url in
                URLSession.shared.dataTaskPublisher(for: url)
            }
            .switchToLatest()
            .map(\.data)
            .compactMap {
                UIImage(data: $0)
            }
            .sink { _ in
            } receiveValue: { [unowned self] image in
                self.image = image
            }
            .store(in: &subscriptions)

    }
}

//: [Next](@next)


