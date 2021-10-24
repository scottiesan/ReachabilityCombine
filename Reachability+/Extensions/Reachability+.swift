//
//  Reachability+.swift
//  Reachability+
//
//  Created by Scott on 10/22/21.
//

import Foundation
import Combine
import Reachability


extension Reachability {
    func connectionPublisher(for connection: Connection? = nil) -> Publishers.ConnectionPublisher {
        return Publishers.ConnectionPublisher(filter: connection)
    }
}
