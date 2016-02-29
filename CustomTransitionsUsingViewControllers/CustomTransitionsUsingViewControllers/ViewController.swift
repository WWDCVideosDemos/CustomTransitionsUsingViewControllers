//
//  ViewController.swift
//  CustomTransitionsUsingViewControllers
//
//  Created by Mr.Alien on 16/2/21.
//  Copyright © 2016年 wrcj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var subView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        subView = UIView(frame: CGRectMake(0,0,40,40))
        subView.backgroundColor = UIColor.grayColor()
        subView.center = CGPointZero
        view.addSubview(subView)
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let transitionCoordinator = self.transitionCoordinator()
        transitionCoordinator?.notifyWhenInteractionEndsUsingBlock({ (ctx) -> Void in
            if ctx.isCancelled() {
                // do some clean code in viewDidAppear
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        performBasicAnimationPartly()
//        performSpringAnimation()
//        performKeyframeAniamtion()
//        createSnapShot()
//        performPushCompleteHandle()
        
    }
    
    func createSnapShot() {
        let aView = subView.snapshotViewAfterScreenUpdates(true)
        let aSubView = view.resizableSnapshotViewFromRect(subView.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        print(aView)
        print(aSubView)
    }
    
    func performBasicAnimationPartly() {
        UIView.animateWithDuration(1.0) { () -> Void in
            
            UIView.performWithoutAnimation({ () -> Void in
                self.subView.center = self.view.center
            })
            self.subView.alpha = 0.5;
            
        }
    }
    
    func performSpringAnimation() {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .OverrideInheritedOptions, animations: { () -> Void in
            self.subView.center = self.view.center
            
            }, completion: nil)
    }
    
    func performKeyframeAniamtion() {
        /*
        UITabBarControllerDelegate
        UINavigationControllerDelegate
        UIViewControllerTransitioningDelegate
        UIViewControllerAnimatedTransitioning
        */
//        UIViewControllerInteractiveTransitioning
        
        self.transitioningDelegate = self
        
        UIView.animateKeyframesWithDuration(4.0,
            delay: 0.0,
            options: .AllowUserInteraction,
            animations: { () -> Void in
                
                //Frame 1  after 2s start,duration: 0.8, remain: 1.2
                UIView.addKeyframeWithRelativeStartTime(0.5,
                    relativeDuration: 0.2,
                    animations: { () -> Void in
                        self.subView.center = CGPointMake(self.view.center.x, 0)
                })
                
                // Frame 2 after 2.8s start,duration: 1.2, remain: 0.0
                UIView.addKeyframeWithRelativeStartTime(0.7,
                    relativeDuration: 0.3,
                    animations: { () -> Void in
                        self.subView.center = self.view.center
                })
            },
            completion: nil)
    }
    
    func performPushCompleteHandle() {
        self.navigationController?.pushViewController(self, animated: true)
        let transitionCoordinator =  self.navigationController?.transitionCoordinator()
        transitionCoordinator?.animateAlongsideTransition(nil, completion: { (ctx) -> Void in
            // do completion handle
        })
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator()
    }
    
    // 必须实现了animationControllerForDismissedController,才会被调用
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return Interactor(vc: self)
    }
    
    // 必须实现了animationControllerForPresentedController,才会被调用
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return Interactor(vc: self)
    }
}

class Animator:NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    }
    
    func animationEnded(transitionCompleted: Bool) {
//        UIPercentDrivenInteractiveTransition
        
    }
    
}

class Interactor:UIPercentDrivenInteractiveTransition {
    init(vc: UIViewController) {
        let swipe = UISwipeGestureRecognizer(target: vc, action: "handleSwipe:")
        swipe.direction = .Down
        swipe.numberOfTouchesRequired = 1
        
        vc.view.addGestureRecognizer(swipe)
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        print("----");
        
    }
}

