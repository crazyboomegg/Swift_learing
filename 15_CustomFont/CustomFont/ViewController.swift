//
//  ViewController.swift
//  CustomFont
//
//  Created by Simon Ng on 18/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customFont1 = UIFont(name: "Canter-Bold", size: 30.0) {
            
            let fontMetrics = UIFontMetrics(forTextStyle: .title1)
            label1.font = fontMetrics.scaledFont(for: customFont1)
            }
      
        if let customFont2 = UIFont(name: "Hallo sans light", size :20.0) {
            let fontMetrics = UIFontMetrics(forTextStyle: .headline)
            label2.font = fontMetrics.scaledFont(for: customFont2)
        }
        
        if let customFont3 = UIFont(name: "Canter-Bold3D", size: 17.0) {
            let fontMetrics = UIFontMetrics(forTextStyle: .subheadline)
            label3.font = fontMetrics.scaledFont(for: customFont3)
        }
        
        label1.adjustsFontForContentSizeCategory = true
        label2.adjustsFontForContentSizeCategory = true
        label3.adjustsFontForContentSizeCategory = true
        
        
        /*
         label1.font = UIFont.preferredFont(forTextStyle: .title1)
         label2.font = UIFont.preferredFont(forTextStyle: .headline)
         label3.font = UIFont.preferredFont(forTextStyle: .subheadline)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

