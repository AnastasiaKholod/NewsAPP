//
//
//
//  ArticlesView
//

import UIKit

final class ArticlesView: UIView {
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
        
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = UIColor.Main.almostBlack
        obj.font = UIFont.boldSystemFont(ofSize: 18)
        obj.text = "News"
        obj.numberOfLines = 12
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
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
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom).offset(32.sizeH)
            make.left.right.equalToSuperview().inset(16.sizeW)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15.sizeH)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-49.sizeH)
        }
    }
}
