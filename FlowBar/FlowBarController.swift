//
//  FlowBarController.swift
//  FlowBar
//
//  Created by Will Fletcher on 3/31/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import UIKit
import CoreMotion

public class FlowBarController: UITabBarController, Flowable {
    
    public var firstTab: UIView?
    public var secondTab: UIView?
    public var thirdTab: UIView?
    public var fourthTab: UIView?
    public var fifthTab: UIView?
    public var bar: UIView!
    
    lazy public var flow: Flow = Flow(self)
    
    // Used for getting device motion updates
    let motionQueue = OperationQueue()
    let motionManager = CMMotionManager()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bar = self.tabBar
        
        tabBar.subviews[0].tintColor = .yellow
        tabBar.subviews[1].tintColor = .black
        tabBar.itemPositioning = .centered
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        configureTabs()
        animate()
        
        switch flowStyle {
        case "rainstick":
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: flow.activateRainstick(motion:error:))
        case "bookshelf":
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: flow.activateBookShelfGravity(motion:error:))
        default:
            print("default")
        }
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func configureTabs() {
        
        // Initialize tab properties according to the number of tabs on the tab bar
        // Note: Tab bar's UIBarBackground counts as a subview at index 0. This is why indexing for tabs begins at index 1
        
        switch tabBar.subviews.count {
        case 1:
            print("FlowBar contains no tabs")
        case 2:
            firstTab = self.tabBar.subviews[1]
        case 3:
            firstTab = self.tabBar.subviews[1]
            secondTab = self.tabBar.subviews[2]
            
        case 4:
            firstTab = self.tabBar.subviews[1]
            secondTab = self.tabBar.subviews[2]
            thirdTab = self.tabBar.subviews[3]
            
        case 5:
            firstTab = self.tabBar.subviews[1]
            secondTab = self.tabBar.subviews[2]
            thirdTab = self.tabBar.subviews[3]
            fourthTab = self.tabBar.subviews[4]
        default: break
        }
    }
    
    public func animate() {
        self.flow.perfromFlowAnimation()
    }
}
