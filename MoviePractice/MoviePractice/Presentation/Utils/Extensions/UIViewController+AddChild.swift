//
//  UIViewController+AddChild.swift
//  MoviePractice
//
//  Created by 전성훈 on 2023/10/25.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
