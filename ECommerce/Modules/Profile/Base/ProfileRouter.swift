//
//  UserProfileRouter.swift
//  ECommerce
//
//  Created by Alex on 1.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol ProfileRouterProtocol {
    func toLogin()
    func toAddresses()
    func toPaymentInfo()
    func toOrderHistory()
}

final class ProfileRouter {
    
    private weak var view: UIViewController?
    private let windowManager: RootWindowManagerProtocol?
    
    init(view: UIViewController, windowManager: RootWindowManagerProtocol) {
        self.view = view
        self.windowManager = windowManager
    }
    
    static func startProfileModule() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter(view: view, windowManager: RootWindowManager.shared)
        let interactor = ProfileInteractor(userInfoManager: UserInfoManager(), authManager: AuthManager())
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    func toLogin() {
        let loginModule = UINavigationController(rootViewController: LoginRouter.startLogin())
        windowManager?.changeRootViewController(loginModule, animated: true)
    }
    
    func toAddresses() {
        let addressesModule = AddressesRouter.startAddressesModule()
        self.view?.navigationController?.pushViewController(addressesModule, animated: true)
    }
    
    func toPaymentInfo() {
        let paymentInfoModule = PaymentInfoRouter.startPaymentInfoModule()
        self.view?.navigationController?.pushViewController(paymentInfoModule, animated: true)
    }
    
    func toOrderHistory() {
        let orderHistoryVC = OrderHistoryViewController()
        self.view?.navigationController?.pushViewController(orderHistoryVC, animated: true)
    }
}
