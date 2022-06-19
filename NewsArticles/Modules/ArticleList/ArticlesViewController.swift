    //
    //
    //
    //  ArticlesViewController.swift
    //

import UIKit
import WebKit

final class ArticlesViewController: UIViewController {
    private var mainView = ArticlesView()
    
    var dataSource: [Article]? {
        didSet {
            guard dataSource != nil else { return }
            mainView.tableView.reloadData()
        }
    }
    
    var webView: WKWebView!
    
        // MARK: - Functions
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.tableView.registerReusableCell(ArticlesTableViewCell.self)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        ServiceLayer.request(router: Router.getTopHeadlines) { [weak self] (result: Result<ArticlesResponse, Error>) in
            switch result {
            case .success (let result):
                self?.dataSource = result.articles
            case .failure:
                print(result)
            }
        }
    }
}

    // MARK: - UITableViewDelegate, UITableViewDataSource
extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticlesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.item = dataSource?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: dataSource?[indexPath.row].source.url ?? "https://google.com") else { return }
        
        let vc = WebViewController(url: url, title: "")
        navigationController?.present(vc, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}


