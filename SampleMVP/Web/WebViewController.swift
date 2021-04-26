//
//  WebViewController.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/27.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    // presenterのインスタンスを保持
    private var presenter: WebPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 中身をVCが知る必要はない
        presenter.viewDidLoaded()
    }
    
    func inject(presenter: WebPresenter) {
        self.presenter = presenter
    }
}

extension WebViewController: WebPresenterOutput {
    func load(request: URLRequest) {
        self.webView.loadRequest(request)
    }
}
