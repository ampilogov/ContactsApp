//
//  ProgressSynchronizer.swift
//  Contacts
//
//  Created by v.ampilogov on 18/01/2019.
//

import UIKit

protocol ProgressSynchronizerDelegate: class {
    func didUpdate(updater: AnyObject, progress: Double)
}

protocol ProgressUpdating: class {
    func update(_ progress: Double)
}

class ProgressSynchronizer: ProgressSynchronizerDelegate {
    
    private var listeners = WeakList<ProgressUpdating>()
    private var currentUpdater: AnyObject?
    private var currentClearTask: DispatchWorkItem?
    
    func addListener(_ listener: ProgressUpdating) {
        listeners.append(listener)
    }

    //MARK: - ProgressSynchronizerDelegate
    
    func didUpdate(updater: AnyObject, progress: Double) {
        
        // Save current updater
        if currentUpdater == nil { currentUpdater = updater }
        
        // Sync progress from only one updater
        guard currentUpdater === updater else { return }
        
        // Update all listeners exept updater itself
        listeners.filter({ $0 !== updater }).forEach({ $0.update(progress) })
        
        // Clear current updater after dalay in order to save new updater
        clearUpdaterAfterDelay()
    }
    
    private func clearUpdaterAfterDelay() {
        currentClearTask?.cancel()
        let item = DispatchWorkItem(block: {
            self.currentUpdater = nil
        })
        currentClearTask = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: item)
    }
}
