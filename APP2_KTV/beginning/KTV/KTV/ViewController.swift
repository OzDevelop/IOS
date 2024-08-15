//
//  ViewController.swift
//  KTV
//
//  Created by hyeonggyu.kim on 2023/09/06.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.loginButton.layer.cornerRadius = 19
        self.loginButton.layer.borderColor = UIColor(named: "main-brown")?.cgColor
        self.loginButton.layer.borderWidth = 1
    }

    @IBAction func buttonDidTap(_ sender: Any) {
    }
    
}

