//: [Previous](@previous)

import Combine
import UIKit
import SwiftUI

enum APIError: Error {
    case url(URLError?)
    case badResponse(statusCode: Int)
    case unknown(Error)
    
    static func convert(error: Error) -> APIError {
        switch error {
        case is URLError:
            return .url((error as! URLError))
        case is APIError:
            return error as! APIError
        default:
            return .unknown(error)
        }
    }
}

// Any error will terminate the publisher stream. Keep the in the flatMap will not terminate the main stream.

// setFailureType to a publisher never fails.
// Use mapError, replaceError to manipulate.
// Use catch to do more: 1. return Empty() to ignore the error. 2. Anything else.

class ImageFetcher {
    
    @Published var images = [UIImage]()
    
    let urlStringSubject = CurrentValueSubject<String, Never>("")
    
    var subscriptions = Set<AnyCancellable>()
    
    func fetchData(for url: URL) -> AnyPublisher<Data, APIError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw APIError.badResponse(statusCode: response.statusCode)
                }
                return data
            }
            .mapError({ error in
                APIError.convert(error: error)
            })
            .eraseToAnyPublisher()
    }
    
    init() {
        
        urlStringSubject
            .compactMap {  URL(string: $0) }
        
            // Set failure type for upstream which will never fail.
//            .setFailureType(to: APIError.self)
        
        
            .flatMap { url -> AnyPublisher<UIImage, Never> in
                self.fetchData(for: url)
                    .compactMap {
                        UIImage(data: $0)
                    }
                    .retry(2)
                
                // When error occurs, the publishers complete. To bypass that we can
                    .catch { _ in
                        return Empty()
                    }
                //  .replaceError(with: UIImage(systemName: "heart")!)
                
                
                    .eraseToAnyPublisher()
            }
        
            .scan([UIImage](), { all, next in
                all + [next]
            })
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [unowned self] image in
                self.images = images
            }
            .store(in: &subscriptions)
    }
}

//: [Next](@next)
