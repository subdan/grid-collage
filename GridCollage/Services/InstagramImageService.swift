//
//  InstagramService.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import CoreData

class TransportCall {
    weak var dataTask: URLSessionDataTask?
    func cancel() {
        dataTask?.cancel()
    }
}

class InstaImageTransport {
    func obtainAll(_ accessToken: String, _ completion: @escaping (Data?)->() ) -> TransportCall {
        let transportCall = TransportCall()
        guard let url = InstagramURLBuilder.getRecentMediaURL(accessToken: accessToken) else {
            return transportCall
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completion(data)
        }
        transportCall.dataTask = dataTask
        dataTask.resume()
        return transportCall
    }
}

class ServiceCall {
    weak var transportCall: TransportCall?
    func cancel() {
        transportCall?.cancel()
    }
}

struct InstaImage {
    let id: String
    let url: String
    let likes: Int
}

class InstaImageParser {
    func parse(data: Data) -> [InstaImage] {
        let decoder = JSONDecoder()
        var result = [InstaImage]()
        do {
            let recentMedia = try decoder.decode(RecentMedia.self, from: data)
            for item in recentMedia.data {
                guard item.type == .image else {
                    continue
                }
                let instaImage = InstaImage(
                    id: item.id,
                    url: item.images.standardResolution.url,
                    likes: item.likes.count
                )
                result.append(instaImage)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return result
    }
}

class InstaImageCache {
    
    func save(_ instaImages: [InstaImage]) {
        
        var ids = [String]()
        let fetchRequest: NSFetchRequest<InstaImageEntity> = InstaImageEntity.fetchRequest()
        do {
            let instaImageEntities = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            ids = instaImageEntities.map { $0.id }
        } catch let error {
            print(error.localizedDescription)
        }
        
        for instaImage in instaImages {
            if ids.contains(instaImage.id) == false {
                let entity = InstaImageEntity(context: CoreDataStack.shared.viewContext)
                entity.id = instaImage.id
                entity.likes = instaImage.likes
                entity.url = instaImage.url
            }
        }
        CoreDataStack.shared.saveContext()
    }
    
    func load() -> [InstaImage] {
        var result = [InstaImage]()
        let fetchRequest: NSFetchRequest<InstaImageEntity> = InstaImageEntity.fetchRequest()
        let sortByLikes = NSSortDescriptor(key: "likes", ascending: false)
        fetchRequest.sortDescriptors = [sortByLikes]
        do {
            let instaImageEntities = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            result = instaImageEntities.map { (instaImageEntity) -> InstaImage in
                return InstaImage(id: instaImageEntity.id, url: instaImageEntity.url, likes: instaImageEntity.likes)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return result
    }
    
}

class InstagramImageService {
    
    let cache = InstaImageCache()
    let parser = InstaImageParser()
    let transport = InstaImageTransport()
    
    func obtainRecentImagesSortedByLikes(accessToken: String, _ completion: @escaping ([InstaImage]) -> ()) -> ServiceCall {
        let serviceCall = ServiceCall()
        let transportCall = transport.obtainAll(accessToken) { [weak self] data in
            guard let data = data else {
                if let instaImages = self?.cache.load() {
                    DispatchQueue.main.async {
                        completion(instaImages)
                    }
                }
                return
            }
            
            var instaImages = self!.parser.parse(data: data)
            instaImages.sort(by: { (a, b) -> Bool in
                return a.likes > b.likes
            })
            self?.cache.save(instaImages)
            DispatchQueue.main.async {
                completion(instaImages)
            }
        }
        serviceCall.transportCall = transportCall
        return serviceCall
    }
    
}
