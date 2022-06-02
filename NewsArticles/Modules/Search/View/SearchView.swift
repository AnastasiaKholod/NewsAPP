//
//
//
//  SearchView
//	NewsArticle
//

import UIKit

class SearchView: UIView {
    let navigationView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .Main.background
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 15
        obj.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //shadow
        obj.layer.masksToBounds = false
        obj.layer.shadowOpacity = 0.08
        obj.layer.shadowRadius = 7
        obj.layer.shadowOffset.height = 7
        obj.layer.shadowColor = UIColor.black.cgColor
        return obj
    }()
    
    let searchTextField: UITextField = {
        let obj = UITextField()
        obj.cornerRadius = 20
        
        obj.textAlignment = .left
        obj.font = UIFont.systemFont(ofSize: 15.sizeW)
        obj.textColor = UIColor.Main.almostBlack
        obj.backgroundColor = UIColor.Main.backgroundGrey
        
        obj.keyboardType = .default
        obj.returnKeyType = .done
        obj.autocorrectionType = .no
        obj.autocapitalizationType = .none
        
        let magnifyingGlassAttachment = NSTextAttachment(data: nil, ofType: nil)
        magnifyingGlassAttachment.image = UIImage(named: "magnifyingGlass")
        let magnifyingGlassString = NSAttributedString(attachment: magnifyingGlassAttachment)

        var attributedText = NSMutableAttributedString(attributedString: magnifyingGlassString)

        let searchString = NSAttributedString(string: " Search")

        attributedText.append(searchString)

        obj.attributedPlaceholder = attributedText
        obj.setLeftPaddingPoints(10)

        return obj
    }()
        
    let sortButton: UIButton = {
       let obj = UIButton()
        obj.setImage(UIImage(named: "sort"), for: .normal)
        return obj
    }()
    
    let filterButton: UIButton = {
       let obj = UIButton()
        obj.setImage(UIImage(named: "filter"), for: .normal)
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = UIColor.Main.almostBlack
        obj.font = UIFont.boldSystemFont(ofSize: 18)
        obj.text = "Search history"
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
        obj.estimatedRowHeight = 50
        obj.rowHeight = UITableView.automaticDimension
        obj.separatorStyle = .none
        obj.backgroundColor = UIColor.Main.backgroundGrey
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.Main.backgroundGrey
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(navigationView)
        navigationView.addSubview(searchTextField)
        navigationView.addSubview(sortButton)
        navigationView.addSubview(filterButton)
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(46.sizeH)
            make.width.equalTo(220.sizeW)
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().inset(16.sizeW)
        }
        
        filterButton.snp.makeConstraints { make in
            make.size.equalTo(46.sizeH)
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.left.equalTo(searchTextField.snp.right).offset(16.sizeW)
        }
        
        sortButton.snp.makeConstraints { make in
            make.size.equalTo(46.sizeH)
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.left.equalTo(filterButton.snp.right).offset(16.sizeW)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(17.sizeH)
            make.left.right.equalToSuperview().inset(16.sizeW)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15.sizeH)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaInsets.bottom)
        }
    }
}
