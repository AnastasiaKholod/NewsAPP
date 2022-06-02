    //
    //
    //
    //  FilterViewController.swift
    //	NewsArticle
    //

import UIKit

struct Filters {
    var from: String?
    var to: String?
    var searchIn: [NSBinarySearchingOptions]?
}

class FilterViewController: UIViewController {
    var mainView = FilterView()
    var filters = Filters()
    
        // MARK: - Functions
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.tableView.registerReusableCell(SearchInTableViewCell.self)
        mainView.tableView.registerReusableCell(DateTableViewCell.self)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        setUpNavigationBar()
        mainView.applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
    }
    
        //    override func viewWillDisappear(_ animated: Bool) {
        //      let presenter =  presentingViewController as? SearchViewController
        //        presenter?.filters = filters
        //    }
}

    //MARK: Set up NavigationBar
extension FilterViewController {
    fileprivate func setUpNavigationBar() {
        let imageAttachment = NSTextAttachment(data: nil, ofType: nil)
        imageAttachment.image = UIImage(named: "trash")?.withRenderingMode(.alwaysTemplate)
        let imageString = NSMutableAttributedString(attachment: imageAttachment)
        let attributedText = NSAttributedString(attributedString: imageString)
        let finalString = NSMutableAttributedString(string: "Clear ")
        
        finalString.append(attributedText)
        
        let orangeAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.Main.orange ]
        finalString.addAttributes(
            orangeAttribute,
            range: NSMakeRange(
                0,
                finalString.length
            )
        )
        
        let label = UILabel()
        label.attributedText = finalString
        label.sizeToFit()
        let leftBarButton = UIBarButtonItem(customView: label)
        
        navigationItem.rightBarButtonItem = leftBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
    }
}

    // MARK: - UITableViewDelegate, UITableViewDataSource
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: DateTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = "From"
            cell.pickedDateChanged = { [weak self] pickedDate in
                    //convert date into ISO
                
                let date = pickedDate
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions.insert(.withFractionalSeconds)
                let ISOstring = formatter.string(from: date)
                
                self?.filters.from = ISOstring
            }
            return cell
        case 1:
            let cell: DateTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = "To"
            cell.pickedDateChanged = { [weak self] pickedDate in
                    //convert date into ISO
                let date = pickedDate
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions.insert(.withFractionalSeconds)
                let ISOstring = formatter.string(from: date)
                
                self?.filters.to = ISOstring
            }
            return cell
        case 2:
            let cell: SearchInTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: SearchInTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            let vc = SearchInViewController()
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension FilterViewController {
    @objc private func applyTapped() {
        let presenter =  navigationController?.viewControllers[0] as? SearchViewController
        presenter?.filters = filters
        navigationController?.popToRootViewController(animated: true)
        presenter?.getSearchResults(text: presenter?.currentSearchValue ?? "") { [weak presenter] articles in
            presenter?.articles = articles.articles
        }
    }
}
