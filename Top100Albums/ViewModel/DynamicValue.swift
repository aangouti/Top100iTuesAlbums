//
//  DynamicValue.swift
//  Top100Albums
//
//  Created by Abbas Angouti on 7/4/20.
//  Copyright © 2020 Abbas Angouti. All rights reserved.
//

import Foundation

class DynamicValue<T> {
    typealias completionHandler = ((T) -> ())
    private var observers = [String : completionHandler]()
    
    var value: T {
        didSet {
            self.notify()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject,
                            completion: @escaping completionHandler) {
        observers[observer.description] = completion
    }
    
    public func addAndNotify(_ observer: NSObject,
                             completion: @escaping completionHandler) {
        observers[observer.description] = completion
        self.notify()
    }
    
    private func notify() {
        observers.forEach { $0.value(value) }
    }
    
    deinit {
        observers.removeAll()
    }
}
