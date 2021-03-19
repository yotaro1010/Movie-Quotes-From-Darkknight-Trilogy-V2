//
//  Test2.swift
//  DemoV11
//
//  Created by Yotaro Ito on 2021/03/10.
//
import UIKit
import Foundation
class PopUpController: UIPresentationController {
    
    var overlayView = UIView()
    
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        overlayView.frame = containerView.bounds
        overlayView.backgroundColor = UIColor.black

        overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(PopUpController.overlayViewDidTouch(_:)))]
        
        overlayView.alpha = 0.0
        
        containerView.addSubview(overlayView)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
            self?.overlayView.alpha = 0.3
        }, completion:nil)
    }
    
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
            self?.overlayView.alpha = 0.0
        }, completion:nil)
    }
    
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
//        overlayView.frame = containerView!.bounds
        presentedView?.translatesAutoresizingMaskIntoConstraints = false
        presentedView?.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        presentedView?.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
        presentedView?.heightAnchor.constraint(equalTo: overlayView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        presentedView?.widthAnchor.constraint(equalTo: overlayView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        
        presentedView?.layer.borderWidth = 2.0
        presentedView?.layer.borderColor = UIColor.black.cgColor
        presentedView?.layer.cornerRadius = 25
        presentedView?.clipsToBounds = true
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }
    
    @objc func overlayViewDidTouch(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
