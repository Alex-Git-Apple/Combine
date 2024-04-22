import UIKit
import Combine

var subscription = Timer.publish(every: 0.1, on: .main, in: .common)
    .autoconnect()
    .print("Stream")
    .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
    .scan(0, { count, _ in
        return count + 1
    })
    .filter({
        $0 > 5 && $0 < 15
    })
    .sink { output in
        print("Finished stream with \(output)")
    } receiveValue: { value in
        print("received value \(value)")
    }

RunLoop.main.schedule(after: .init(Date(timeIntervalSinceNow: 20))) {
    print("++++ cancel subscription.")
    subscription.cancel()
}



