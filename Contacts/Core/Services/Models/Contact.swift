//
//  Contact.swift
//  Contacts
//
//  Created by v.ampilogov on 18/01/2019.
//

import UIKit

struct Contact: Decodable {
    let firstName: String
    let lastName: String
    let avatarFilename: String
    let title: String
    let introduction: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarFilename = "avatar_filename"
        case title
        case introduction
    }
}
