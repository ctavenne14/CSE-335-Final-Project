//
//  Entity+CoreDataProperties.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/14/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "UserEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
