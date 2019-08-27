//
//  ViewExtentension.swift
//  City ATMs
//
//  Created by admin on 8/21/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
