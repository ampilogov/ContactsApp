//
//  ContactsViewController.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit

class ContactsViewController: UIViewController {
    
    private let progressSynchronizer = ProgressSynchronizer()
    private let contactsService = ContactsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "Contacts"
        self.view.backgroundColor = .white
        
        placeSubmodules()
    }
    
    private func placeSubmodules() {
        
        let contacts = contactsService.fetchContacts()
        
        let avatarsViewController = AvatarsViewController(avatars: contacts.map({ AvatarViewModel(contact: $0) }))
        addChild(avatarsViewController)
        view.addSubview(avatarsViewController.view)
        avatarsViewController.view.pin(height: 120)
        avatarsViewController.view.pin(leading: 0, top: 0, trailing: 0)
        avatarsViewController.didMove(toParent: self)
        avatarsViewController.delegate = progressSynchronizer
        
        let descriptionViewController = DescriptionViewController(descriptions: contacts.map({ DescriptionViewModel(contact: $0) }))
        addChild(descriptionViewController)
        view.addSubview(descriptionViewController.view)
        descriptionViewController.view.pin(leading: view.leadingAnchor,
                                           top: avatarsViewController.view.bottomAnchor,
                                           trailing: view.trailingAnchor,
                                           bottom: view.bottomAnchor)
        descriptionViewController.didMove(toParent: self)
        descriptionViewController.delegate = progressSynchronizer
            
        progressSynchronizer.addListener(avatarsViewController)
        progressSynchronizer.addListener(descriptionViewController)
    }
}
