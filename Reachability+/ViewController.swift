//
//  ViewController.swift
//  Reachability+
//
//  Created by Scott on 10/22/21.
//

import UIKit
import Reachability
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var connectionLbl: UILabel!
    var subscriptions:Set<AnyCancellable>? = Set<AnyCancellable>()
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       try? Reachability().connectionPublisher()
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: {
                print($0)
                self.connectionLbl.text = $0.description
            })
            .store(in: &subscriptions!)
    

    }
}



