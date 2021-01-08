//
//  IconDetailViewController.swift
//  CollectionViewDemo
//
//  Created by 江柏毅 on 2020/12/29.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class IconDetailViewController: UIViewController {
    
    
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = icon?.name
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = icon?.description
            descriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.image = UIImage(named: icon?.imageName ?? "")
        }
    }
    
    @IBOutlet var priceLabel: UILabel! {
        didSet {
            if let icon = icon {
                priceLabel.text = "$\(icon.price)"
            }
        }
    }
    var icon: Icon?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
   

}
