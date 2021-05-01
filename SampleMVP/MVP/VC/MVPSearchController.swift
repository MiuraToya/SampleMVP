//
//  ViewController.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import UIKit

class MVPSearchController: UIViewController {
    
    private var indicator = UIActivityIndicatorView()
   
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        indicator.isHidden = true
        print("viewdid\(self.presenter)")
    }
    
    // Presenterのインスタンスを保持
    var presenter: GitHubPresenterInput!
    func inject(presenter: GitHubPresenterInput) {
        print("yobareta")
        self.presenter = presenter
        print("")
    }
    @IBAction func search(_ sender: Any) {
        guard let searchText = searchText.text else { return }
        presenter.search(with: searchText)
    }
}

extension MVPSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selected(index: indexPath.row)
    }
}

extension MVPSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("テストPRE \(self.presenter)")
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
        tableView.reloadData()
    }
    
    func upData(load: Bool) {
        tableView.isHidden = load
        indicator.isHidden = !load
    }
    
    func get(error: Error) {
        print(error.localizedDescription)
    }
    
    func showWeb(Repositoly: Repository) {
        Router.shared.showWeb(from: self, repositoly: Repositoly)
    }
    
    
}
