//
//  AvatarViewModel.swift
//  Contacts
//
//  Created by v.ampilogov on 18/01/2019.
//

import Foundation

struct AvatarViewModel {
    let imageName: String
    
    init(contact: Contact) {
        self.imageName = contact.avatarFilename
    }
}
