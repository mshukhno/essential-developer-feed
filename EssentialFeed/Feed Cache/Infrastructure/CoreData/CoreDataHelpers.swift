//
//  CoreDataHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 12/01/2025.
//

import CoreData

extension NSPersistentContainer {
    enum LoadingError: Error {
        case modelNotFound
        case failedToLoadPersistentStores(Error)
    }
    
    static func load(
        modelName: String,
        url: URL,
        in bundle: Bundle
    ) throws -> NSPersistentContainer {
        guard let model = NSManagedObjectModel.with(name: modelName, in: bundle) else {
            throw LoadingError.modelNotFound
        }
        
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        
        var loadError: Error?
        container.loadPersistentStores { loadError = $1 }
        
        try loadError.map { throw LoadingError.failedToLoadPersistentStores($0) }
        
        return container
    }
}

private extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
}
