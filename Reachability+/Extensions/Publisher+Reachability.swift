//
//  Publisher+Reachability.swift
//  Reachability+
//
//  Created by Scott on 10/22/21.
//

import Foundation
import Combine
import Reachability


extension Publishers {
    typealias Connection = Reachability.Connection
    class ConnectionSubscription<S: Subscriber>: Subscription where S.Input == Connection, S.Failure == Never {
        func request(_ demand: Subscribers.Demand) {
            // optional
        }
        
        func cancel() {
            subscriber = nil
            reachablity.stopNotifier()
        }
        
        let reachablity = try! Reachability()
        private var subscriber: S?
        
        init(connection: Connection? = nil, subscriber: S) {
            self.subscriber = subscriber
            try? reachablity.startNotifier()
            reachable(for: connection)
        }
    
        func reachable(for connection: Connection? = nil) {
            
            reachablity.whenReachable = { [weak self] reachability in
                
                guard connection != nil else {
                    _ = self?.subscriber?.receive(reachability.connection)
                    return
                }
 
                let conn = connection == reachability.connection ? connection! : .unavailable
                _ = self?.subscriber?.receive(conn)
            }

            reachablity.whenUnreachable = { [weak self] Connection in
                
                _ = self?.subscriber?.receive(.unavailable)
            }
        }
    }
}

extension Publishers {
    
    struct ConnectionPublisher: Publisher {
        typealias Output = Connection
        typealias Failure = Never
        var connection: Connection?
        init(filter connection: Connection? = nil) {
            self.connection = connection
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Publishers.Connection == S.Input {
            let subscription = ConnectionSubscription(connection: connection,subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
    
}
