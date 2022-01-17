//
//  MainCoordinator.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

final class MainCoordinator: Coordinator {
    
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Private Methods
    
    private let window: UIWindow
    
    // MARK: - Public Methods
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let mainCoordinator = TeamsCoordinator(navigationController: navigationController)
        coordinate(to: mainCoordinator)
    }
}
