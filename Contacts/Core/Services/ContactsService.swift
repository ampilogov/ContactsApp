//
//  ContactsService.swift
//  Contacts
//
//  Created by v.ampilogov on 18/01/2019.
//

import Foundation

protocol IContactsService {
    func fetchContacts() -> [Contact]
}

class ContactsService {

    func fetchContacts() -> [Contact] {
        guard let path = Bundle.main.url(forResource: "contacts", withExtension: "json"),
            let jsonData = try? Data(contentsOf: path),
            let contacts = try? JSONDecoder().decode([Contact].self, from: jsonData)
            else { return [] }
        
        return contacts
    }
}
