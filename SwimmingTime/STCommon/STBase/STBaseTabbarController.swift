//
//  STBaseTabbarController.swift
//  SwimmingTime
//
//  Created by 龚梦洋 on 2023/7/27.
//

import Foundation
import UIKit

class STBaseTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatChildViewControllers()
    }
    
    private func creatChildViewControllers() {
        let vc1 = STHomeViewController()
        vc1.tabBarItem.image = UIImage(named: "chronograph")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "chronographed")?.withRenderingMode(.alwaysOriginal)
        let navi1 = STBaseNavigationController(rootViewController: vc1)
        
        let vc2 = STRecordViewController()
        vc2.tabBarItem.image = UIImage(named: "clockRecord")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage(named: "clockRecorded")?.withRenderingMode(.alwaysOriginal)
        let navi2 = STBaseNavigationController(rootViewController: vc2)
        
        viewControllers = [navi1, navi2]
    }
}
