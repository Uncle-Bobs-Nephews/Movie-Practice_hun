//
//  LoginFlowCoordinator.swift
//  MoviePractice
//
//  Created by 전성훈 on 2023/11/01.
//

import UIKit

protocol LoginFlowCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
}

final class LoginFlowCoordinator: Coordinator {
    var type: CoordinatorType { .login }

    weak var finishDelegate: CoordinatorFinishDelegate?
    var tabBarViewController: TabBarDelegate? = nil

    var childCoordinators: [Coordinator] = []
    var viewController: UINavigationController
    
    var viewTitle: String? = nil
    
    private let dependencies: LoginFlowCoordinatorDependencies!
    
    private weak var loginVC: LoginViewController?
    
    init(
        viewController: UINavigationController,
        dependencies: LoginFlowCoordinatorDependencies
    ) {
        self.viewController = viewController
        self.dependencies = dependencies
    }
    
    deinit {
        print("Coordinator Deinit")
    }
    
    func start() {
        let actions = LoginViewModelActions(showTabBar: showTabBar)
        let vc = dependencies.makeLoginViewController(actions: actions)
        
        if let title = viewTitle {
            vc.title = title
        }
        
        viewController.pushViewController(vc, animated: false)
        
        loginVC = vc 
    }
    
    private func showTabBar() {
        self.finish()
    }
}
