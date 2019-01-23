//
//  ContactsTests.swift
//  ContactsTests
//
//  Created by v.ampilogov on 22/01/2019.
//

import XCTest
@testable import Contacts

class ContactsTests: XCTestCase {

    let contactsService = ContactsService()

    // Check parsing json to model
    func testContactParsing() {
        let contacts = contactsService.fetchContacts()
        let contact = contacts[0]
        
        XCTAssert(contact.firstName == "Allan")
        XCTAssert(contact.lastName == "Munger")
        XCTAssert(contact.avatarFilename == "Allan Munger.png")
        XCTAssert(contact.title == "Writer")
        XCTAssert(contact.introduction == "Ut malesuada sollicitudin tincidunt. Maecenas volutpat suscipit efficitur. Curabitur ut tortor sit amet lacus pellentesque convallis in laoreet lectus. Curabitur lorem velit, bibendum et vulputate vulputate, commodo in tortor. Curabitur a dapibus mauris. Vestibulum hendrerit euismod felis at hendrerit. Pellentesque imperdiet volutpat molestie. Nam vehicula dui eu consequat finibus. Phasellus sed placerat lorem. Nulla pretium a magna sit amet iaculis. Aenean eget eleifend elit. Ut eleifend aliquet interdum. Cras pulvinar elit a dapibus iaculis. Nullam fermentum porttitor ultrices.")
    }
    
    
    
    // Check that number of avatars is equal number of descriptions
    func testModelsCount() {
        let contacts = contactsService.fetchContacts()
        let avatars = contacts.compactMap({ AvatarViewModel(contact: $0) })
        let descriptions = contacts.compactMap({ DescriptionViewModel(contact: $0) })
        
        XCTAssert(avatars.count == descriptions.count)
    }
    
    // Check that synchronizer filter events from listener
    func testSyncronizerUpdateListener() {
        let listener = MockProgressListener()
        let synchronizer = ProgressSynchronizer()
        
        synchronizer.addListener(listener)
        synchronizer.didUpdate(updater: self, progress: 1)
        
        XCTAssert(listener.progress == 1)
        XCTAssert(listener.updateDidCall)
    }
    
    // Check that synchronizer filter events from listener
    func testSyncronizerFilterEvents() {
        let listener = MockProgressListener()
        let synchronizer = ProgressSynchronizer()
        
        synchronizer.addListener(listener)
        synchronizer.didUpdate(updater: listener, progress: 1)
        
        XCTAssert(!listener.updateDidCall)
    }
}
