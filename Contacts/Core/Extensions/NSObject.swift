//
//  NSObject.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import Foundation

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }
    
    static var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}
