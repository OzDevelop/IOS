//
//  TabbarController.swift
//  KTV
//
//  Created by 변상필 on 8/17/24.
//

import UIKit

class TabbarController: UITabBarController {
    
    // 각 뷰들이 TabbarController의 Child View 이기 때문에 여기서 회전 처리를 해주어야 전체적으로 들어감
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait } // 회전에 대한 처리
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
