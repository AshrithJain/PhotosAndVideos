//
//  Coordinator.swift
//  PhotosAndVideosApp
//
//  Created by Ashrith Jain on 13/02/21.
//  Copyright © 2021 Ashrith Jain. All rights reserved.
//

import Foundation


public protocol Event {}

protocol EventHandlers{
    func propagate<T: Event>(event: T)
    func raise<T: Event>(event: T)
    func addHandler<T: Event>(_ handler: @escaping (T) -> Void)
}
protocol EventHandleable {}
private class EventHandlerContainer<T>:EventHandleable{
       private var handlers: [(T) -> Void] = []
    
    func add(handler: @escaping (T) -> Void) {
        handlers.append(handler)
    }
    
    func propagate(event: T) {
        for handler in handlers {
            handler(event)
        }
    }
}

class Coordinator:NSObject{
    private var parent:Coordinator?
    fileprivate lazy  var children = NSHashTable<Coordinator>.weakObjects()
    private var handlerContainer: [String : EventHandleable] = [:]
    private override init() {}
    
    public  init(parent:Coordinator?) {
        super.init()
        parent?.addChild(child: self)
    }
    
    func addChild(child:Coordinator?){
        child?.parent = self
        
        let enumeratedObjects = children.objectEnumerator()
        let duplicateCoordinator = enumeratedObjects.filter { (existingChild) -> Bool in
            return type(of: existingChild.self) ==  type(of: child.self)
        }
        if let coordiantors = duplicateCoordinator as? [Coordinator] {
             removeChild(coordiantors)
        }
        children.add(child)
    }
    
    func removeChild(_ coordinators: [Coordinator]) {
        coordinators.forEach { (child) in
            children.remove(child)
        }
    }
    func removeAllChildrens() {
        children.removeAllObjects()
    }
}

extension Coordinator:EventHandlers{
    
    public func addHandler<T: Event>(_ handler: @escaping (T) -> Void) {
        let eType = String(reflecting: type(of: T.self))
        var container = handlerContainer[eType]
        if container == nil {
            container = EventHandlerContainer<T>()
            handlerContainer[eType] = container
        }
        if let container = container as? EventHandlerContainer<T> {
            container.add(handler: handler)
        }
    }
    
    public func propagate<T: Event>(event: T) {
        let etype = String(reflecting: type(of: T.self))
        
        if let handler = handlerContainer[etype] as? EventHandlerContainer<T> {
            handler.propagate(event: event)
        }
        
        children.allObjects.forEach {
            $0.propagate(event: event)
        }
    }
    
    func raise<T: Event>(event: T, from sender: EventHandlers) {
        guard let parent = parent else {
            propagate(event: event)
            
            return
        }
        
        parent.raise(event: event, from: sender)
    }
    
    public func raise<T: Event>(event: T) {
        raise(event: event, from: self)
    }
}
