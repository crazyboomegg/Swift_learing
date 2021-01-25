//
//  MenuTransitionManager.swift
//  SlideDownMenu
//
//  Created by 江柏毅 on 2021/1/13.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit


@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
   
    
    var delegate: MenuTransitionManagerDelegate?
    
   
   
    
    
    let duration = 0.5
    var isPresenting = false
    
    var snapshot:UIView? {
        
        didSet {
            if let delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: delegate, action: #selector(delegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
        
    }
    

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }

 

   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
        return
    }
    
    guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else{
        return
    }
   
    let container = transitionContext.containerView
    let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
    let moveUp = CGAffineTransform(translationX: 0, y: -50)
    
    if isPresenting {
        toView.transform = moveUp
        snapshot = fromView.snapshotView(afterScreenUpdates: true)
        container.addSubview(toView)
        container.addSubview(snapshot!)
    }
    
    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
        
        if self.isPresenting {
            self.snapshot?.transform = moveDown
            toView.transform = CGAffineTransform.identity
        } else {
            self.snapshot?.transform = CGAffineTransform.identity
            fromView.transform = moveUp
        }
        
    }, completion: {
        finished in
        
        transitionContext.completeTransition(true)
        
        if !self.isPresenting {
            self.snapshot?.removeFromSuperview()
        }
    })
}
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    
}

