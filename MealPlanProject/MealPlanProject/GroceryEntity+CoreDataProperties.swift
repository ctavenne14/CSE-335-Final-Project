//
//  GroceryEntity+CoreDataProperties.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/15/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//
//

import Foundation
import CoreData


extension GroceryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryEntity> {
        return NSFetchRequest<GroceryEntity>(entityName: "GroceryEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var details: String?

}
