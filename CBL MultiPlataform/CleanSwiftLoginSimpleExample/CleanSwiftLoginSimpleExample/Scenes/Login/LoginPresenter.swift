//
//  LoginPresenter.swift
//  CleanSwiftLoginSimpleExample
//
//  Created by Ronaldo Gomes on 14/05/21.
//

import Foundation

// Uso de typealias para facilitar a legibilidade
typealias LoginPresenterInput = LoginInteractorOutput
typealias LoginPresenterOutput = LoginViewControllerInput

// No caso ela não declara protocolos pois ja estao declarados no interactor e view controller

final class LoginPresenter: LoginPresenterInput {
    
    // Contem uma fraca referencia a view controller, que é o output da Presenter
    weak var viewController: LoginPresenterOutput?
    
    // MARK: Função chamadas pelo Interactor, atraves do protocolo LoginPresenterInput
    
    func showLogingFailure(message: String) {
        //Chama a view controller passando  os dados recebidos pelo interactor
        viewController?.showLoginFailure(message: message)
    }
    
    func showLogingSuccess(user: CleanLoginUser) {
        viewController?.showLoginSucess(fullUserName: user.firstName + " " + user.lastName)
    }

}
