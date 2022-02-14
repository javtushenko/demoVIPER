//
//  Interactor.swift
//  demoVIPER
//
//  Created by Николай Явтушенко on 14.02.2022.
//

import Foundation

protocol AnyInteractorProtocol {
    
    var presenter: AnyPresenterProtocol? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractorProtocol {
    
    var presenter: AnyPresenterProtocol?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let _ = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([UserEntity].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }.resume()
    }
}
