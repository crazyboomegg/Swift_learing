//
//  SidebarMenu.swift
//  SlidebarMenu
//
//  Created by 江柏毅 on 2021/1/9.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addSideBarMenu(leftMenuButton: UIBarButtonItem?, rightMenuButton: UIBarButtonItem? = nil) {
        if revealViewController() != nil {
            if let menuButton = leftMenuButton {
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            }
            
            if let extraButton = rightMenuButton {
                revealViewController().rightViewRevealWidth = 150
                extraButton.target = revealViewController()
                extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            }
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
}
