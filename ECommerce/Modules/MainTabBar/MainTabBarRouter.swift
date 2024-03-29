//
//  MainTabBarRouter.swift
//  ECommerce
//
//  Created by Alex on 30.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol MainTabBarRouterProtocol {
    
}

final class MainTabBarRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startTabBarModule() -> UIViewController {
        let view = MainTabBarViewController()
        let router = MainTabBarRouter(view: view)
        let interactor = MainTabBarInteractor(basketManager: BasketManager())
        let presenter = MainTabBarPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension MainTabBarRouter: MainTabBarRouterProtocol {
    
}
