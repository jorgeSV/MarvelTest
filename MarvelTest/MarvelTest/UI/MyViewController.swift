//
//  MyViewController.swift
//  MarvelTest
//
//  Created by jorgeSV on 10/5/21.
//

import UIKit
import SkeletonView
import JGProgressHUD

class MyViewController: UIViewController {

    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MyViewController {
    
    func showProgress() {
        showProgress(in: self.view)
    }
    
    func showProgress(in startingView: UIView) {
        
        self.view.isUserInteractionEnabled = false
        
        if startingView.isSkeletonable {
            let gradient = SkeletonGradient(baseColor: UIColor.clouds)
            let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
            startingView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            
        } else {
            hud.textLabel.text = "Loading"
            hud.show(in: startingView)
        }
    }
    
    func hideProgress() {
        hideProgress(in: self.view)
    }
    
    func hideProgress(in startingView: UIView) {
        
        DispatchQueue.main.async {
            
            if startingView.isSkeletonable {
                startingView.hideSkeleton(reloadDataAfter: true)
                startingView.isSkeletonable = false
                
            } else {
                self.hud.dismiss(afterDelay: 0.25)
            }
            
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    func showError(error: Error) {
        
        self.hud.textLabel.text = "Error"
        self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
        self.hud.show(in: self.view)
        self.hud.dismiss(afterDelay: 10.0)
    }
}
