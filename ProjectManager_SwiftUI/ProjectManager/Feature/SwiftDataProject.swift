//
//  SwiftDataProject.swift
//  ProjectManager
//
//  Created by Erick on 3/29/24.
//

import Foundation
import SwiftData

@Model
final class SwiftDataProject {
  @Attribute(.unique) var id: UUID
  var title: String
  var body: String
  var deadline: Date
  var projectState: ProjectState
  
  init(
    id: UUID,
    title: String,
    body: String,
    deadline: Date,
    projectState: ProjectState
  ) {
    self.id = id
    self.title = title
    self.body = body
    self.deadline = deadline
    self.projectState = projectState
  }
}

extension SwiftDataProject {
  func convertToProject() -> Project {
    Project(
      id: id,
      title: title,
      body: body,
      deadline: deadline,
      projectState: projectState
    )
  }
}
