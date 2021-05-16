//
//  LoginViewController.swift
//  CleanSwiftLoginSimpleExample
//
//  Created by Ronaldo Gomes on 14/05/21.
//

import UIKit

// São os dados passados pelo Presenter para controller no fim do ciclo VIP
protocol LoginViewControllerInput: AnyObject {
    func showLoginSucess(fullUserName: String)
    func showLoginFailure(message: String)
}

// É ação passada para o interactor
protocol LoginSceneViewControllerOutput: AnyObject {
    func tryToLogIn()
}

// Implementação da view controller
final class LoginViewController: UIViewController, LoginViewControllerInput {
    
    // Instancias do interactor, com seu input
    var interactor: LoginInteractorInput?
    
    // Instancia do router, que chama outra scene
    var router: LoginRoutingLogic?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        // Chama o interactor para fazer manipular a logica de negocio do login. Dessa forma tira a responsabilidade da VC
        interactor?.tryToLogIn()
    }
    
    // MARK: Funções chamadas no fim do ciclo VIP, pelo Presenter
    
    func showLoginSucess(fullUserName: String) {
        // Chama o router para passar para a proxima scene
        router?.showLoginSuccess()
    }
    
    func showLoginFailure(message: String) {
        // Chama o router para passar para a proxima scene
        router?.showLogingFailure(message: message)
    }
    
}
