//
//  EmailCell.swift
//  TempyMail
//
//  Created by Abraham Estrada on 12/28/21.
//

import UIKit

class EmailCell: UITableViewCell {
    
    // MARK: - Properties
    
    var email: Email? {
        didSet{configure()}
    }
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let senderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 12)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 12)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 12)
        return label
    }()
    
    // MARK: - Lifestyle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = CUSTOMGRAY
        
        addSubview(bubbleView)
        bubbleView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(bodyLabel)
        bodyLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let email = email else {return}
        titleLabel.text = email.title
        bodyLabel.text = email.body
    }
}
