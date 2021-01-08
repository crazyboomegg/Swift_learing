//
//  IconCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Simon Ng on 22/11/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class IconCollectionViewController: UICollectionViewController {
    
    
    private var shareEnabled = false
    
    private var selectedIcons: [(icon: Icon, snapshot: UIImage)] = []
    
    @IBOutlet var shareButton: UIBarButtonItem!
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
        guard shareEnabled else {
            shareEnabled = true
            collectionView?.allowsMultipleSelection = true
            shareButton.title = "Done"
            shareButton.style = UIBarButtonItem.Style.plain
            
            return
        }
        
        guard selectedIcons.count > 0 else {
            return
        }
        
        
        
    }

    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
  
    private var iconSet: [Icon] = [ Icon(name: "candle", imageName: "candle", description: "Halloween icons designed by Tania Raskalova.", price: 3.99, isFeatured: false),
                                    Icon(name: "cat", imageName: "cat", description: "Halloween icon designed by Tania Raskalova.", price: 2.99, isFeatured: true),
                                    Icon(name: "dribbble", imageName: "dribbble", description: "Halloween icon designed by Tania Raskalova.", price: 1.99, isFeatured: false),
                                    Icon(name: "ghost", imageName: "ghost", description: "Halloween icon designed by Tania Raskalova.", price: 4.99, isFeatured: false),
                                    Icon(name: "hat", imageName: "hat", description: "Halloween icon designed by Tania Raskalova.", price: 2.99, isFeatured: false),
                                    Icon(name: "owl", imageName: "owl", description: "Halloween icon designed by Tania Raskalova.", price: 5.99, isFeatured: true),
                                    Icon(name: "pot", imageName: "pot", description: "Halloween icon designed by Tania Raskalova.", price: 1.99, isFeatured: false),
                                    Icon(name: "pumkin", imageName: "pumkin", description: "Halloween icon designed by Tania Raskalova.", price: 0.99, isFeatured: false),
                                    Icon(name: "rip", imageName: "rip", description: "Halloween icon designed by Tania Raskalova.", price: 7.99, isFeatured: false),
                                    Icon(name: "skull", imageName: "skull", description: "Halloween icon designed by Tania Raskalova.", price: 8.99, isFeatured: false),
                                    Icon(name: "sky", imageName: "sky", description: "Halloween icon designed by Tania Raskalova.", price: 0.99, isFeatured: false),
                                    Icon(name: "Toxic icon", imageName: "toxic", description: "Halloween icon designed by Tania Raskalova.", price: 2.99, isFeatured: false),
                                    Icon(name: "Book icon", imageName: "ic_book", description: "Colorful icon designed by Marin Begović.", price: 2.99, isFeatured: false),
                                    Icon(name: "Backpack icon", imageName: "ic_backpack", description: "Colorful icon designed by Marin Begović.", price: 3.99, isFeatured: false),
                                    Icon(name: "Camera icon", imageName: "ic_camera", description: "Colorful camera icon designed by Marin Begović.", price: 4.99, isFeatured: false),
                                    Icon(name: "Coffee icon", imageName: "ic_coffee", description: "Colorful icon designed by Marin Begović.", price: 3.99, isFeatured: true),
                                    Icon(name: "Glasses icon", imageName: "ic_glasses", description: "Colorful icon designed by Marin Begović.", price: 3.99, isFeatured: false),
                                    Icon(name: "Icecream icon", imageName: "ic_ice_cream", description: "Colorful icon designed by Marin Begović.", price: 4.99, isFeatured: false),
                                    Icon(name: "Smoking pipe icon", imageName: "ic_smoking_pipe", description: "Colorful icon designed by Marin Begović.", price: 6.99, isFeatured: false),
                                    Icon(name: "Vespa icon", imageName: "ic_vespa", description: "Colorful icon designed by Marin Begović.", price: 9.99, isFeatured: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items
        return iconSet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
        
        // Configure the cell
        let icon = iconSet[indexPath.row]
        cell.iconImageView.image = UIImage(named: icon.name)
        cell.iconPriceLabel.text = "$\(icon.price)"
        cell.backgroundView = (icon.isFeatured) ? UIImageView(image: UIImage(named: "feature-bg")) : nil
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: "icon-selected"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIconDetail" {
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as! IconDetailViewController
                
                destinationController.icon = iconSet[indexPaths[0].row]
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard shareEnabled else {
            return
        }
        
        let selectedIcon = iconSet[indexPath.row]
        if let snapshot = collectionView.cellForItem(at: indexPath)?.snapshot {
            selectedIcons.append((icon: selectedIcon, snapshot: snapshot))
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard shareEnabled else {
            return
        }
        
        let deSelectedIcon = iconSet[indexPath.row]
        
        if let index = selectedIcons.firstIndex(where:{ $0.icon.name == deSelectedIcon.name }) {
            selectedIcons.remove(at: index)
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showIconDetail" {
            if shareEnabled {
                return false
            }
        }
        return true
    }
    
    
    
}
