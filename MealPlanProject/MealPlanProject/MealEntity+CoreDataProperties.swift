//
//  MealEntity+CoreDataProperties.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/14/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//
//

import Foundation
import CoreData


extension MealEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealEntity> {
        return NSFetchRequest<MealEntity>(entityName: "MealEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var instructions: String?
    @NSManaged public var picture: NSData?

}
