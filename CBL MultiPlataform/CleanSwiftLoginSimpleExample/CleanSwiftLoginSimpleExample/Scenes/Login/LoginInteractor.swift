//
//  LoginInteractor.swift
//  CleanSwiftLoginSimpleExample
//
//  Created by Ronaldo Gomes on 14/05/21.
//

import Foundation

// Usar typealias para melhor legibilidade do codigo
typealias LoginInteractorInput = LoginSceneViewControllerOutput

// É a ação passada para o Presenter
protocol LoginInteractorOutput: AnyObject {
    func showLogingSuccess(user: CleanLoginUser)
    func showLogingFailure(message: String)
}

// Nesse caso nao precisamos criar um input, pois ele ja é definido na view controller

// Implementação do interactor
final class LoginInteractor: LoginInteractorInput {
    
    // Instancia para o Presenter, como input
    var presenter: LoginPresenterInput?
    
    // Instancia do worker, que faz a logica do interactor. Pode haver mais de um worker.
    var authWorker: LoginAuthLogic?
    
    
    // MARK: Funções chamadas pela view controller, pelo protocolo LoginInteractorInput
    
    func tryToLogIn() {
        
        // Chama o worker para fazer a autenticação, passando uma completion
        authWorker?.makeAuth(completion: { result in
            DispatchQueue.main.async { [weak self] in
                
                // E dentro da completion, chama o presenter. Dessa forma o worker nao conhece o presenter, sendo responsavel soemente pela sua função
                switch result {
                case .success(let data):
                    self?.presenter?.showLogingSuccess(user: data)
                case .failure(let error):
                    self?.presenter?.showLogingFailure(message: error.localizedDescription)
                }
            }
        })
    }
}
