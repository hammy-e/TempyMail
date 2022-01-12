//
//  MainViewController.swift
//  TempyMail
//
//  Created by Abraham Estrada on 12/27/21.
//

import UIKit
import SwiftyJSON

private let cellIdentifier: String = "cell"

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var inbox: [Email] = []
    
    private var API = GuerrillaMailAPIService()
    
    private let tempyMailLabel: UILabel = {
        let label = UILabel()
        label.text = "TempyMail"
        label.textColor = .white
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 32)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 16
        tf.textAlignment = .center
        tf.placeholder = "Please Refresh Email"
        tf.isEnabled = false
        tf.setHeight(42)
        return tf
    }()
    
    private lazy var newAddressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Email", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 40, width: 90)
        button.layer.cornerRadius = 16
        button.backgroundColor = CUSTOMGREEN
        button.addTarget(self, action: #selector(handleNewAddressTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var copyToClipboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Copy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 40, width: 90)
        button.layer.cornerRadius = 16
        button.backgroundColor = CUSTOMGREEN
        button.addTarget(self, action: #selector(handleCopyToClipboardTapped), for: .touchUpInside)
        return button
    }()
    
    private let inboxLabel: UILabel = {
        let label = UILabel()
        label.text = "Inbox"
        label.textColor = .white
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 18)
        return label
    }()
    
    private let inboxTableView: UITableView = {
        let tw = UITableView()
        tw.backgroundColor = CUSTOMGRAY
        tw.layer.cornerRadius = 12
        tw.rowHeight = 80
        return tw
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        inboxTableView.dataSource = self
        inboxTableView.delegate = self
        API.delegate = self
        API.startSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    
    @objc func handleNewAddressTapped() {
        print("new address")
    }
    
    @objc func handleCopyToClipboardTapped() {
        print("copy to clipboard")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = CUSTOMBLUE
        
        view.addSubview(tempyMailLabel)
        tempyMailLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        view.addSubview(emailTextField)
        emailTextField.centerX(inView: view, topAnchor: tempyMailLabel.bottomAnchor, paddingTop: 36)
        emailTextField.setWidth(view.frame.width - 75)
        
        let stack = UIStackView(arrangedSubviews: [newAddressButton, copyToClipboardButton])
        stack.axis = .horizontal
        stack.spacing = 45
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: emailTextField.bottomAnchor, paddingTop: 12)
        
        view.addSubview(inboxLabel)
        inboxLabel.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 36)
        
        view.addSubview(inboxTableView)
        inboxTableView.anchor(top: inboxLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 36, paddingBottom: 36, paddingRight: 36)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inbox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EmailCell()
        cell.email = inbox[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - GuerrillaMailAPIServiceDelegate

extension MainViewController: GuerrillaMailAPIServiceDelegate {
    
    func didStartSession(data: JSON) {
        let session = Session(data: data)
        DispatchQueue.main.async {
            self.emailTextField.text = session.emailAddress
        }
    }
}
