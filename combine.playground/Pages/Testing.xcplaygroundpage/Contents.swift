//: [Previous](@previous)

import Combine

// Use protocol and DI
// Use expecation and wait

// useful operations:
// .drop
// .output(at: Int) specify the element at certain position
// .output(in: <Range>) at certain range
// .collect(_ count: Int) ->  Collect some elements and emits an array
// .contains(where: ) -> find the first element in an upstream that’s equal to the supplied argument.
// .allsatisfy -> Publishes a single Boolean value that indicates whether all received elements pass a given predicate.



/* Debug operator .handleEvents()
func handleEvents(
    receiveSubscription: ((any Subscription) -> Void)? = nil,
    receiveOutput: ((Self.Output) -> Void)? = nil,
    receiveCompletion: ((Subscribers.Completion<Self.Failure>) -> Void)? = nil,
    receiveCancel: (() -> Void)? = nil,
    receiveRequest: ((Subscribers.Demand) -> Void)? = nil
) -> Publishers.HandleEvents<Self>
*/

//: [Next](@next)
