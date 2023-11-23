//
//  Coordinator.swift
//  Clothes
//
//  Created by Joao Marcus Dionisio Araujo on 21/11/23.
//

import UIKit

public protocol Coordinator : AnyObject {

    var children: [Coordinator] { get set }

    var navigationController: UINavigationController { get set}

    func start()
}
