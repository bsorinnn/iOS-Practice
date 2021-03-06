//
//  FirstViewController.swift
//  CoordinatorProject
//
//  Created by 배소린 on 2022/05/23.
//

import UIKit
import Combine

class FirstViewController: UIViewController {
    
    var infoLabel: UILabel?
    var viewModel: FirstTabViewModel!
    var showDetailRequested: () -> () = { }
    
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupInfoLabel()
        setupDetailButton()
    }
    
    func setupDetailButton() {
        let button = UIButton(frame: CGRect(
            x: 30,
            y: 400,
            width: 200,
            height: 60)
        )
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Go to Detail", for: .normal)
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func setupInfoLabel() {
        let infoLabel = UILabel(frame: CGRect(x: 30, y: 300, width: 300, height: 60))
        self.view.addSubview(infoLabel)
        self.infoLabel = infoLabel
        
        viewModel.$email.combineLatest(viewModel.$name)
            .sink{ [weak self](email, name) in
                if name.count + email.count > 0 {
                    self?.infoLabel?.text = "\(name) with email \(email)"
                } else {
                    self?.infoLabel?.text = ""
                }
                
            }.store(in: &subscriptions)
    }
    
    @objc
    func buttonAction() {
        showDetailRequested()
    }

}
