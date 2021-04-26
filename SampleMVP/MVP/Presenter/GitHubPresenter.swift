//
//  GithubPresenter.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import Foundation

// アクションを受け入れる用のプロトコル
protocol GitHubPresenterInput {
    var numberOfItems: Int { get }
    func getRepo(index: Int) -> Repository
    func selected(index: Int)
    func search(with text: String?)
}

// アクションを加える用のプロトコル
protocol GitHubPresenterOutput: AnyObject {
    func upDataRepsitory(_ repository: [Repository])
    func upData(load: Bool)
    func get(error: Error)
    func showWeb(Repositoly: Repository)
}

class GitHubPresenter {
    // アクションを加えるプロトコルに準拠したインスタンスを保持
    private weak var output: GitHubPresenterOutput!
    // API通信用に準拠したインスタンスを取得
    private var api: GitHubAPIProtocol
    
    private var repositoly: [Repository]
    
    init(output: GitHubPresenterOutput, api: GitHubAPIProtocol, repositoly: [Repository]) {
        self.output = output
        self.api = GitHubAPI.shared
        self.repositoly = []
    }
}

// PresenterはInputを受けてOutputするイメージ(外から通知を受けて外に通知を出す)
// outputが具体的に何をしてるかは知らなくても良い
extension GitHubPresenter: GitHubPresenterInput {
    // 数を数えて！
    var numberOfItems: Int { return repositoly.count }
    // 指定されたindexのレポジトリを教えて！
    func getRepo(index: Int) -> Repository {
        return repositoly[index]
    }
    // 指定されたindexのレポジトリが選択された！
    // webを開く通知をする
    func selected(index: Int) {
        self.output.showWeb(Repositoly: repositoly[index])
    }
    // 指定されたtextをもとに検索して！
    func search(with text: String?) {
        guard let text = text, !text.isEmpty else { return }
        // ロード中を通知
        self.output.upData(load: true)
        self.api.getRepository(searchWord: text) { [weak self] result in
            // ロード終了を通知
            self?.output.upData(load: false)
            switch result {
            case .success(let repositoly):
                self?.repositoly = repositoly
            case .failure(let error):
                self?.output.get(error: error)
            }
        }
    }
}
