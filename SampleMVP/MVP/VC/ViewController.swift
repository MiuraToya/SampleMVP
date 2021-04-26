//
//  ViewController.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import UIKit

class ViewController: UIViewController {

    // Presenterのインスタンスを保持
    private var presenter: GitHubPresenter!
    
    private var indicator = UIActivityIndicatorView()
   
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inject(presenter: GitHubPresenter) {
        self.presenter = presenter
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as? RepoCell else
        { return UITableViewCell() }
        
        let repositoly = presenter.getRepo(index: indexPath.row)
        cell.configure(repositoly: repositoly)
        
        return cell
    }
}

extension ViewController: GitHubPresenterOutput {
    func upDataRepsitory(_ repository: [Repository]) {
        tableView.reloadData()
    }
    
    func upData(load: Bool) {
        tableView.isHidden = load
        indicator.isHidden = load
    }
    
    func get(error: Error) {
        print(error.localizedDescription)
    }
    
    func showWeb(Repositoly: Repository) {
        <#code#>
    }
    
    
}
