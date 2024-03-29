//
//  SignUpPresenter.swift
//  ECommerce
//
//  Created by Alex on 26.06.2023.
//

import Foundation

protocol SignUpPresenterInputs {
    func viewDidLoad()
    func toLoginTapped()
    func signUpTapped(email: String?, password: String?)
}

final class SignUpPresenter {
    private weak var view: SignUpViewProtocol?
    private let router: SignUpRouterProtocol?
    private let interactor: SignUpInteractorInputs?
    
    init(view: SignUpViewProtocol, router: SignUpRouterProtocol, interactor: SignUpInteractorInputs) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SignUpPresenter: SignUpPresenterInputs {
    
    func viewDidLoad() {
        
    }
    
    func toLoginTapped() {
        router?.toLogin()
    }
    
    func signUpTapped(email: String?, password: String?) {
        guard let email,
              let password,
              !email.isEmpty,
              !password.isEmpty
        else {
            view?.presentAlert(title: "", message: GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        
        interactor?.signUpTapped(email: email, password: password)
    }
}

extension SignUpPresenter: SignUpInteractorOutputs {
    func signUpSucceed() {
        view?.presentAlert(title: "Verification email sent", message: "After verification, you can login.")
        router?.toLogin()
    }
    
    func signUpFailed(error: FirebaseError) {
        view?.presentAlert(title: "", message: error.localizedDescription)
    }
}
