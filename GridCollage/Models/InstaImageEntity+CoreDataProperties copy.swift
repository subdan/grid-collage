//
//  InstaImageEntity+CoreDataProperties.swift
//  
//
//  Created by Daniil Subbotin on 11/11/2018.
//
//

import Foundation
import CoreData


extension InstaImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InstaImageEntity> {
        return NSFetchRequest<InstaImageEntity>(entityName: "InstaImageEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var url: String
    @NSManaged public var likes: Int

}
