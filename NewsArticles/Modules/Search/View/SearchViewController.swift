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
            self.getSearchResults(text: self.currentSearchValue ?? "") { [weak self] articles in
                self?.articles = articles.articles
            }
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
    
    func getSearchResults(text: String, completion: @escaping (ArticlesResponse)->()) -> () {
        NewsUserDefaults.saveSearchValue(newSearch: text)
        
        var params = [String:String]()
        params["q"] = currentSearchValue
        
        params["from"] = filters?.from
        params["to"] = filters?.to
        
        let api = TopHeadlinesService()
        
        api.getSearchResults(params) { error in
            print(error)
        } success: { [weak self] response in
            self?.articles = response.articles
            self?.mainView.titleLabel.text = "\(response.totalArticles) news"
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
            getSearchResults(text: searchText) { [weak self] articles in
                self?.articles = articles.articles
            }
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


