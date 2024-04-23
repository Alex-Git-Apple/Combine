import UIKit
import Combine

let subscription = Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
    .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
    .scan(0, { count, _ in
        count + 1
    })
    .filter { $0 < 6}
    .sink { completion in
        print("Data stream completion \(completion)")
    } receiveValue: { timestamp in
        print("receive value: \(timestamp)")
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
    subscription.cancel()
}


