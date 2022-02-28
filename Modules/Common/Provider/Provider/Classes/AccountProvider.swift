//
//  AccountProvider.swift
//  Provider
//
//  Created by 方昱恒 on 2022/2/27.
//

public protocol AccountProvider: PGProvider {
    
    func presentLoginViewController(from controller: UIViewController,
                                    animated: Bool,
                                    presentCompletion: (() -> Void)?,
                                    loginCompletion: ((Bool) -> Void)?)
    
}

extension AccountProvider {
    
    public func presentLoginViewController(from controller: UIViewController,
                                    animated: Bool) {
        self.presentLoginViewController(from: controller,
                                        animated: animated,
                                        presentCompletion: nil,
                                        loginCompletion: nil)
    }
    
}