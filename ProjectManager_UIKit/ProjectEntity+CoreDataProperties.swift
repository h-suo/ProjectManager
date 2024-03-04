//
//  ProjectEntity+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 표현수 on 2023/10/04.
//
//

import Foundation
import CoreData

extension ProjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectEntity> {
        return NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var deadline: Date
    @NSManaged public var state: String

}

extension ProjectEntity: Identifiable { }
