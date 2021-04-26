//
//  WebPresenter.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/27.
//

import Foundation

// アクションを受け入れるプロトコル
protocol WebPresenterInput {
    func viewDidLoaded()
}

// アクションを加えるプロトコル
protocol WebPresenterOutput: AnyObject {
    func load(request: URLRequest)
}

final class WebPresenter {
    private weak var output: WebPresenterOutput!
    private var repositoly: Repository
    
    init(output: WebPresenterOutput, repositoly: Repository) {
        self.output = output
        self.repositoly = repositoly
    }
}


extension WebPresenter: WebPresenterInput {
    func viewDidLoaded() {
        guard let url = URL(string: repositoly.urlStr) else { return }
        output.load(request: URLRequest(url: url))
    }
}
