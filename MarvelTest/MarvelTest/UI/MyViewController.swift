//
//  MyViewController.swift
//  MarvelTest
//
//  Created by jorgeSV on 10/5/21.
//

import UIKit
import SkeletonView

class MyViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            startingView.showGradientSkeleton(usingGradient: gradient) // Gradient
            
            startingView.startSkeletonAnimation()
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
            }
            
            self.view.isUserInteractionEnabled = true
        }
        
    }
}
