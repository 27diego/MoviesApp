//
//  CacheService.swift
//  TMDB
//
//  Created by Developer on 1/6/21.
//

import Foundation

final class CacheService<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    init(dateProvider: @escaping () -> Date = Date.init, entryLifetime: TimeInterval = 12*60*60){
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }
    
    func insert(_ value: Value, for key: Key){
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    func value(for key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }
    func remove(forKey key: Key){
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

//conform our key to a subclass of NSObject
private extension CacheService {
    final class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key){
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
}

//make our value a class to store our value
private extension CacheService {
    final class Entry {
        let value: Value
        let expirationDate: Date
        init(_ value: Value, expirationDate: Date){
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

extension CacheService {
    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            guard let value = newValue else {
                remove(forKey: key)
                return
            }
            
            insert(value, for: key)
        }
    }
}
