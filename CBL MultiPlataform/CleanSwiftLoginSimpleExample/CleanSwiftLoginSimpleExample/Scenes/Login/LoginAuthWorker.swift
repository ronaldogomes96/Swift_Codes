//
//  LoginAuthWorker.swift
//  CleanSwiftLoginSimpleExample
//
//  Created by Ronaldo Gomes on 14/05/21.
//

import Foundation

// É a ação chamada pela Presenter, no caso a logica que deve ser implementada
protocol LoginAuthLogic {
    func makeAuth(completion: @escaping (Result<CleanLoginUser, LoginAuthWorker.LoginAuthWorkerError>) -> Void)
}

// Implementação do worker
final class LoginAuthWorker: LoginAuthLogic {
    
    // Instancia de um novo worker, soemente de servicos
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
    }
    
    // Casos de erros do login
    enum LoginAuthWorkerError: Error {
        case authFailed(String)
        case unauthorized
    }
    
    // MARK: Função chamadas pelo Interactor, atraves do protocolo LoginAuthLogic

    func makeAuth(completion: @escaping (Result<CleanLoginUser, LoginAuthWorkerError>) -> Void) {
        
        // Chama outro worker service
        service.auth()
            .sink { _ in } receiveValue: { value in
                
                // E entao chama a completion no interactor
                switch value.authorized {
                case true:
                    completion(.success(CleanLoginUser()))
                case false:
                    completion(.failure(.unauthorized))
                }
            }
    }
}
