//
//  Disposable.swift
//  MoviePractice
//
//  Created by 전성훈 on 2023/09/01.
//

import Foundation

final class Disposables {
    private var disposables: [() -> Void] = []
    
    func add(_ disposable: @escaping () -> Void) {
        disposables.append(disposable)
    }
    
    func dispose() {
        disposables.forEach { $0() }
        disposables.removeAll()
    }
}

final class DisposeBag {
    private let disposables = Disposables()
    
    func add(_ disposable: @escaping () -> Void) {
        disposables.add(disposable)
    }
    
    // 테스트 용
    func clear() {
        disposables.dispose()
    }
    
    deinit {
        disposables.dispose()
    }
}
