//
//  Test2.swift
//  DemoV11
//
//  Created by Yotaro Ito on 2021/03/10.
//
import UIKit
import Foundation
class test2Controller: UIPresentationController {
    
    var overlayView = UIView()

 
        override func presentationTransitionWillBegin() {
            guard let containerView = containerView else {
                return
            }
            
            overlayView.frame = containerView.bounds
            overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(test2Controller.overlayViewDidTouch(_:)))]

            overlayView.alpha = 0.0
            overlayView.backgroundColor = UIColor.black
            
            containerView.insertSubview(overlayView, at: 0)

            // トランジションを実行
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

    let margin = (x: CGFloat(20), y: CGFloat(570))
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width - margin.x, height: parentSize.height - margin.y)
    }

    
        // 呼び出し先のView Controllerのframeを返す
        override var frameOfPresentedViewInContainerView: CGRect {

            var presentedViewFrame = CGRect()
            let containerBounds = containerView!.bounds
            let childContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
            presentedViewFrame.size = childContentSize
            presentedViewFrame.origin.x = margin.x / 2.0
            presentedViewFrame.origin.y = margin.y / 2.0

            return presentedViewFrame
        }


        override func containerViewWillLayoutSubviews() {
            super.containerViewWillLayoutSubviews()
            overlayView.frame = containerView!.bounds
            presentedView?.frame = frameOfPresentedViewInContainerView
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
