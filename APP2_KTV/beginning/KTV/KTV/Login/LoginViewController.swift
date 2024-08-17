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
        // loginViewController와 Tabbar가 같은 Storyboard에 위치하고 있음. -> 스토리 보드를 가져와서 tabbar를 rootViewController로 만들어줌.
        self.view.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabbar")
    }
    
}

