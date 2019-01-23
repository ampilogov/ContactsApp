//
//  DescriptionViewModel.swift
//  Contacts
//
//  Created by v.ampilogov on 21/01/2019.
//

import Foundation

struct DescriptionViewModel {
    let firstName: String
    let lastName: String
    let subtitle: String
    let text: String
    
    init(contact: Contact) {
        firstName = contact.firstName
        lastName = contact.lastName
        subtitle = contact.title
        text = contact.introduction
    }
}
