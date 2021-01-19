//
//  ImageCacheSingleton.swift
//  TMDB
//
//  Created by Developer on 1/18/21.
//

import Foundation

class ImageCacheService {
    static var shared = ImageCacheService()
    var cacheService: CacheService = CacheService<String, Data>()
    func getImage(for url: String) -> Data? {
        if let result = cacheService.value(for: url){
            return result
        }
        
        return nil
    }
    func insert(data: Data, for key: String){
        cacheService.insert(data, for: key)
    }
}
