//
//  Router.swift
//  demoVIPER
//
//  Created by Николай Явтушенко on 14.02.2022.
//

import Foundation
import UIKit

protocol AnyRouterProtocol {
    
    typealias EntryPoint = AnyViewProtocol & UIViewController
    
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouterProtocol
}

class UserRouter: AnyRouterProtocol {
    
    var entry: EntryPoint?

    static func start() -> AnyRouterProtocol {
        let router = UserRouter()
        
        var view: AnyViewProtocol = UserViewController()
        var presenter: AnyPresenterProtocol = UserPresenter()
        var interactor: AnyInteractorProtocol = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
