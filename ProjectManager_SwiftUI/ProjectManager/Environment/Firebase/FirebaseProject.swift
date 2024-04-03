//
//  FirebaseProject.swift
//  ProjectManager
//
//  Created by Erick on 3/29/24.
//

import Foundation

struct FirebaseProject: Codable {
  var id: String
  var title: String
  var body: String
  var deadline: Date
  var projectState: ProjectState
}

extension FirebaseProject {
  func convertToProject() -> Project {
    Project(
      id: UUID(uuidString: id)!,
      title: title,
      body: body,
      deadline: deadline,
      projectState: projectState
    )
  }
}
