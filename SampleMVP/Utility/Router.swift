//
//  Router.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/05/01.
//

import UIKit

final class Router {
    static let shared = Router()
    private init() {}
    private var window: UIWindow?
    
    func showRoot(window: UIWindow) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MVPSearchController else { return }
        // vcとpresenterを参照させ合う(presenterは弱参照でvcを保持)
        let presenter = GitHubPresenter(output: vc)
        vc.inject(presenter: presenter)
        
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func show(from: UIViewController, to: UIViewController) {
        if let nav = from.navigationController {
            nav.pushViewController(to, animated: true)
        } else {
            from.present(to, animated: true, completion: nil)
        }
    }
    
    func showWeb(from: UIViewController, repositoly: Repository) {
        guard let webVc = UIStoryboard(name: "Web", bundle: nil).instantiateInitialViewController() as? WebViewController else { return }
        let presenter = WebPresenter(output: webVc, repositoly: repositoly)
        webVc.inject(presenter: presenter)
        show(from: from, to: webVc)
    }
}
