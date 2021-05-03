//
//  ViewController.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import UIKit

final class MVPSearchController: UIViewController {
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet private weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        indicator.isHidden = true
    }
    
    // Presenterのインスタンスを保持
    private var presenter: GitHubPresenterInput!
    // Routerに繋いでもらう処理がある
    func inject(presenter: GitHubPresenterInput) {
        // Presenterと繋がる
        self.presenter = presenter
    }
   
    // 検索ボタンタップ
    @IBAction func search(_ sender: Any) {
        guard let searchText = searchText.text else { return }
        // Presenterに通知
        presenter.search(with: searchText)
    }
}

extension MVPSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Presenterに通知
        presenter.selected(index: indexPath.row)
    }
}

extension MVPSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Presenterに通知
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as? RepoCell else
        { return UITableViewCell() }
        
        let repositoly = presenter.getRepo(index: indexPath.row)
        cell.configure(repositoly: repositoly)
        
        return cell
    }
}

extension MVPSearchController: GitHubPresenterOutput {
    func upDataRepsitory(_ repository: [Repository]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func upData(load: Bool) {
        DispatchQueue.main.async {
            self.tableView.isHidden = load
            self.indicator.isHidden = !load
        }
    }
    
    func get(error: Error) {
        print(error.localizedDescription)
    }
    
    func showWeb(Repositoly: Repository) {
        DispatchQueue.main.async {
            Router.shared.showWeb(from: self, repositoly: Repositoly)
        }
    }
}
