//
//  Presenter.swift
//  demoVIPER
//
//  Created by Николай Явтушенко on 14.02.2022.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol AnyPresenterProtocol {
    var router: AnyRouterProtocol? { get set }
    var interactor: AnyInteractorProtocol? { get set }
    var view: AnyViewProtocol? { get set }
    
    func interactorDidFetchUsers(with result: Result<[UserEntity], Error>)
}

class UserPresenter: AnyPresenterProtocol {

    var router: AnyRouterProtocol?
    var interactor: AnyInteractorProtocol? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: AnyViewProtocol?
    
    func interactorDidFetchUsers(with result: Result<[UserEntity], Error>) {
        switch result {
        case.success(let users):
            view?.update(with: users)
        case.failure:
            view?.update(with: "Что-то пошло не так")
        }
    }
    
}
