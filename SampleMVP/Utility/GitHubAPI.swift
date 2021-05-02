//
//  GitHubAPI.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import Foundation

enum GitHubError: Error {
    case error
}
// 実際に検索処理をするプロトコル
protocol GitHubAPIProtocol {
    func getRepository(searchWord: String, completion: ((Result<[Repository], GitHubError>) -> Void)?)
}

final  class GitHubAPI: GitHubAPIProtocol {
    static let shared = GitHubAPI()
    private init() {}
    
    func getRepository(searchWord: String, completion: ((Result<[Repository], GitHubError>) -> Void)?) {
        guard searchWord.count >= 0 else {
            completion?(.failure(.error))
            return
        }
    
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars") else { return }
   
        // API通信
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let repositolies = try? JSONDecoder().decode(Item.self, from: data) else { return }
            guard let repositoly = repositolies.items else { return }
            if error != nil {
                completion?(.failure(.error))
                return
            }
            completion?(.success(repositoly))
        }
        // 検索処理実行
        task.resume()
    }
}
