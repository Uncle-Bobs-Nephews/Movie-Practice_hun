//
//  MyPageFlowCoordinator.swift
//  MoviePractice
//
//  Created by 전성훈 on 2023/11/01.
//

import UIKit

protocol MyPageFlowCoordinatorDependencies {
    func makeMyPageViewController(actions: MyPageModelActions) -> MyPageViewController
}

final class MyPageFlowCoordinator: NSObject, Coordinator {
    var type: CoordinatorType { .myPage }
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    weak var tabBarViewController: TabBarDelegate?
    
    var childCoordinators: [Coordinator] = []
    var viewController: UINavigationController
    
    var viewTitle: String? = nil
    
    private let dependencies: MyPageFlowCoordinatorDependencies!
    
    private weak var myPageVC: MyPageViewController?
    
    init(
        viewController: UINavigationController,
        dependencies: MyPageFlowCoordinatorDependencies
    ) {
        self.viewController = viewController
        self.dependencies = dependencies
    }
    
    deinit {
        print("MyPage Coordinator Deinit")
    }
    
    func start() {
        let actions = MyPageModelActions(showLogin: showLogin)
        let vc = dependencies.makeMyPageViewController(actions: actions)
        
        if let title = viewTitle {
            vc.title = title
        }
        
        viewController.pushViewController(vc, animated: false)
        
        myPageVC = vc
    }
    
    private func showLogin() {
        self.finish()
    }
}
