//
//  CustomFocusCell.swift
//  DinoDex
//
//  Created by Nathan Hekman on 1/20/16.
//  Copyright © 2016 NTH. All rights reserved.
//

import UIKit

class CustomFocusCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    var gradient: CAGradientLayer!
    
    override func awakeFromNib() {
        self.gradient = CAGradientLayer()
        self.gradient.colors = [UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor, UIColor(white: 0.0, alpha: 0.0).CGColor]
        self.gradient.startPoint = CGPointMake(0.5, 1)
        self.gradient.endPoint = CGPointMake(0.5, 0.5)
        self.gradient.frame = gradientView.bounds
        self.gradientView.layer.addSublayer(self.gradient)
        
        self.titleLabel.font = UIFont.systemFontOfSize(33.0, weight: UIFontWeightLight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient.frame = self.imageView.bounds
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        coordinator.addCoordinatedAnimations({ () -> Void in
            if context.nextFocusedView === self {
                self.enableFocusedState()
            } else {
                self.disableFocusedState()
            }
            
            }, completion: nil)
    }
    
    func enableFocusedState() {
        
        self.titleLabel.font = UIFont.systemFontOfSize(55.0, weight: UIFontWeightLight)
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -3
        horizontalMotionEffect.maximumRelativeValue = 3
        self.titleLabel.addMotionEffect(horizontalMotionEffect)
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -3
        verticalMotionEffect.maximumRelativeValue = 3
        self.titleLabel.addMotionEffect(verticalMotionEffect)
        
        self.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2)
        
        let gradientHorizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        gradientHorizontalMotionEffect.minimumRelativeValue = -15
        gradientHorizontalMotionEffect.maximumRelativeValue = 15
        self.gradientView.addMotionEffect(gradientHorizontalMotionEffect)
        
        let gradientVerticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        gradientVerticalMotionEffect.minimumRelativeValue = -15
        gradientVerticalMotionEffect.maximumRelativeValue = 15
        self.gradientView.addMotionEffect(gradientVerticalMotionEffect)
        
        self.gradientView.transform = CGAffineTransformMakeScale(1.35, 1.35)
        
    }
    
    func disableFocusedState() {
        self.titleLabel.motionEffects.forEach { self.titleLabel.removeMotionEffect($0) }
        self.gradientView.motionEffects.forEach { self.gradientView.removeMotionEffect($0) }
        
        self.gradientView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.titleLabel.transform = CGAffineTransformIdentity
        self.titleLabel.font = UIFont.systemFontOfSize(33.0, weight: UIFontWeightLight)
        
    }
}