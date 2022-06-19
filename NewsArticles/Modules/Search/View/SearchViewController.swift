    //
    //
    //
    //  SearchViewController.swift
    //	NewsArticle
    //

import UIKit

enum SearchViewControllerState {
    case showingSearchKeywords
    case showingSearchResults
}

class SearchViewController: UIViewController {
    var mainView = SearchView()
    var currentSearchValue: String? {
        didSet {
            getSearchResults(text: self.currentSearchValue ?? "")
        }
    }
    var state: SearchViewControllerState = .showingSearchResults
    
    var filters:Filters?
    
    var searchKeywords: [String]? {
        didSet {
            guard searchKeywords != nil else { return }
            state = .showingSearchKeywords
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
                self.mainView.titleLabel.text = "Search history"
            }
        }
    }
    
    var articles: [Article]? {
        didSet {
            guard articles != nil else { return }
            state = .showingSearchResults
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
        // MARK: - Functions
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func initViewController() {
        mainView.tableView.registerReusableCell(SearchHistoryTableViewCell.self)
        mainView.tableView.registerReusableCell(ArticlesTableViewCell.self)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchTextField.delegate = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        searchKeywords = NewsUserDefaults.searchValues()
        
        mainView.filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        mainView.sortButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        mainView.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    deinit {
        print("\(type(of: self)) deinited")
    }
    
    func getSearchResults(text: String) -> () {
        NewsUserDefaults.saveSearchValue(newSearch: text)
        
        var params = [URLQueryItem]()
        params.append(URLQueryItem(name: "q", value: currentSearchValue))
        params.append(URLQueryItem(name: "from", value: filters?.from))
        params.append(URLQueryItem(name: "to", value: filters?.to))
        
        ServiceLayer.request(router: .getSearchResults, params: params) { [weak self] (result: Result<ArticlesResponse, Error>) in
            switch result {
            case .success (let result):
                self?.articles = result.articles
                self?.mainView.titleLabel.text = "\(result.totalArticles) news"            case .failure:
                print(result)
            }
        }
    }
}

    // MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .showingSearchKeywords:
            return searchKeywords?.count ?? 0
        case .showingSearchResults:
            return articles?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .showingSearchKeywords:
            let cell: SearchHistoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = searchKeywords?[indexPath.row]
            return cell
        case .showingSearchResults:
            let cell: ArticlesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.item = articles?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .showingSearchKeywords:
            let searchText = NewsUserDefaults.searchValues()[indexPath.row]
            mainView.searchTextField.text = "\(searchText)"
            currentSearchValue = searchText
            getSearchResults(text: searchText)
        case .showingSearchResults:
            guard let url = URL(string: articles?[indexPath.row].source.url ?? "https://google.com") else { return }
            
            let vc = WebViewController(url: url, title: "")
            navigationController?.present(vc, animated: false, completion: nil)
        }
    }
}

extension SearchViewController {
    @objc private func filterTapped() {
        let vc = FilterViewController()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func sortTapped() {
        let alert = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        for i in ["Upload date", "Relevance"] {
            alert.addAction(UIAlertAction(title: i, style: .default, handler: doSomething))
        }
        self.present(alert, animated: true, completion: nil)
    }
    func doSomething(action: UIAlertAction) {
    }
}

    //MARK: TextField delegate
extension SearchViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.searchKeywords = NewsUserDefaults.searchValues()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if self.currentSearchValue != textField.text {
            self.currentSearchValue = textField.text
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.searchKeywords = NewsUserDefaults.searchValues()
        }
    }
}


