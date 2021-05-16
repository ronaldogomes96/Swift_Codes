//
//  LoginConfigurator.swift
//  CleanSwiftLoginSimpleExample
//
//  Created by Ronaldo Gomes on 15/05/21.
//

import Foundation

// É a ação que o configurator ira fazer
protocol LoginConfigurator {
    func configured(_ vc: LoginViewController) -> LoginViewController
}

// Implementação do configurator. Ele tira a responsabilidade do ciclo VIP
final class DefaultLoginConfigurator: LoginConfigurator {
    
    // Instancia do scene factory, que ira construir a scene
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
      }
    
    // É responsavel por criar toda scene e passar a view controller
    @discardableResult
    func configured(_ vc: LoginViewController) -> LoginViewController {
        // Passa o delegate do configurator
        sceneFactory.configurator = self
        
        // Cria as instancias usadas no ciclo VIP
        let service = DefaultAuthService(
            networkManager: DefaultNetworkManager(session: MockNetworkSession())
        )
        let authWorker = LoginAuthWorker(service: service)
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter(sceneFactory: sceneFactory)
        
        // Passa as respectivas instancias
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.authWorker = authWorker
        vc.interactor = interactor
        vc.router = router
        
        // Retorna a view controller
        return vc
    }
    
    
}
