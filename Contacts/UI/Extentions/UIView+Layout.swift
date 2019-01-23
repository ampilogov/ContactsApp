//
//  UIView+Layout.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit

extension UIView {
    
    func pinToSuperviewCenter() {
        guard  let superview = superview else { return }
        enableAutolayoutIfNeeded()
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func pinToSuperview(leading: CGFloat = 0,
                               top: CGFloat = 0,
                               trailing: CGFloat = 0,
                               bottom: CGFloat = 0) {
        
        guard  let superview = superview else { return }
        enableAutolayoutIfNeeded()
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
    }
    
    func pin(leading: NSLayoutXAxisAnchor? = nil,
                    top: NSLayoutYAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil) {
        
        enableAutolayoutIfNeeded()
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: top).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
    }
    
    func pin(leading: CGFloat? = nil,
                    top: CGFloat? = nil,
                    trailing: CGFloat? = nil,
                    bottom: CGFloat? = nil) {
        
        guard  let superview = superview else { return }
        enableAutolayoutIfNeeded()
        if let leading = leading {
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: leading).isActive = true
        }
        if let top = top {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: trailing).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: bottom).isActive = true
        }
        
    }
    
    func pin(width: CGFloat? = nil,
                    height: CGFloat? = nil) {
        
        enableAutolayoutIfNeeded()
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func enableAutolayoutIfNeeded() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
