//
//
//
//  SearchInViewController.swift
//	NewsArticle
//

import UIKit

enum SortOptions: String {
    case title = "Title"
    case description = "Description"
    case content = "Content"
}

class SearchInViewController: UIViewController {
    var mainView = SearchInView()
    let sortOptions:[SortOptions] = [.title, .description, .content]
    
    // MARK: - Functions
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.tableView.registerReusableCell(SearchInOptionTableViewCell.self)
        mainView.tableView.registerReusableCell(DateTableViewCell.self)

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        setUpNavigationBar()

    }
}

    //MARK: Set up NavigationBar
    extension SearchInViewController {
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
extension SearchInViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchInOptionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = sortOptions[indexPath.row].rawValue
        cell.searchSwitch.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            let vc = SearchInViewController()
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

