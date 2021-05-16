//
//  LoginRouter.swift
//  CleanSwiftLoginSimpleExample
//
//  Created by Ronaldo Gomes on 14/05/21.
//

import Foundation
import UIKit

// Sao as logicas necessarias para o router
protocol LoginRoutingLogic {
    func showLoginSuccess()
    func showLogingFailure(message: String)
}

// Implementação do router
final class LoginRouter: LoginRoutingLogic {
    
    // Referencia fraca para a proxima view controller
    weak var source: UIViewController?
    
    // Referencia de uma factory que ira construir o objeto da proxima scene
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    // MARK: Funções chamadas pela controller, atraves do protocolo LoginRoutingLogic

    func showLoginSuccess() {
        // O factory configura a scene
        let scene = sceneFactory.makeLoginScene()
        
        // Entao a controller chama a view
        source?.navigationController?.pushViewController(scene, animated: true)
    }
    
    func showLogingFailure(message: String) {
        source?.present(UIAlertController(title: "", message: message, preferredStyle: .actionSheet), animated: true)
    }
}
