# ReachabilityCombine

Add publisher to Reachability for convenience.

usage: 

       try? Reachability().connectionPublisher()
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: {
                print($0)
                self.connectionLbl.text = $0.description
            })
            .store(in: &subscriptions!)
    }
    
    // for specific connection 
     try? Reachability().connectionPublisher(for: .wifi)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: {
                print($0)
                self.connectionLbl.text = $0.description
            })
            .store(in: &subscriptions!)
    }
