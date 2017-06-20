//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Len512 on 16/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    
    // MARK: - UIPresentationController methods
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    // Insert the gradient view between the Search View and Detaill View controllers
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
        
        // Make the gradient fade in while the popup bounces into view
        dimmingView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
            }, completion: nil)
        }
    }
    // animate the gradient view out of sight when the Detail popup is dismissed
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
}
