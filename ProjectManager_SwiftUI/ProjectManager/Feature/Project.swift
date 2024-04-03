//
//  Project.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import Foundation

enum ProjectState: String, CaseIterable, Codable {
  case todo = "TODO"
  case doing = "DOING"
  case done = "DONE"
}

struct Project: Identifiable, Equatable {
  var id: UUID
  var title: String
  var body: String
  var deadline: Date
  var projectState: ProjectState
  var isExceed: Bool { Calendar.compareDate(deadline) ?? false }
  
  init(
    id: UUID = UUID(),
    title: String,
    body: String,
    deadline: Date,
    projectState: ProjectState = .todo
  ) {
    self.id = id
    self.title = title
    self.body = body
    self.deadline = deadline
    self.projectState = projectState
  }
}

extension Project {
  func convertToSwiftDataProject() -> SwiftDataProject {
    SwiftDataProject(
      id: id,
      title: title,
      body: body,
      deadline: deadline,
      projectState: projectState
    )
  }
  
  func convertToFirebaseProject() -> FirebaseProject {
    FirebaseProject(
      id: id.uuidString,
      title: title,
      body: body,
      deadline: deadline,
      projectState: projectState
    )
  }
}
