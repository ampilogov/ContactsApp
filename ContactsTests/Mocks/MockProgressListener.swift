//
//  MockProgressListener.swift
//  ContactsTests
//
//  Created by v.ampilogov on 22/01/2019.
//

import Foundation
@testable import Contacts

class MockProgressListener: ProgressUpdating {
    
    var updateDidCall = false
    var progress: Double?
    
    func update(_ progress: Double) {
        self.updateDidCall = true
        self.progress = progress
    }
}
