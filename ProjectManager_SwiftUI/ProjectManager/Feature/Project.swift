//
//  Project.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import Foundation
import SwiftData

enum ProjectState: String, CaseIterable, Codable {
  case todo = "TODO"
  case doing = "DOING"
  case done = "DONE"
}

@Model
final class Project {
  @Attribute(.unique) var deadline: Date
  var title: String
  var body: String
  var projectState: ProjectState
  var isExceed: Bool { Calendar.compareDate(deadline) ?? false }
  
  init(
    title: String,
    body: String,
    deadline: Date,
    projectState: ProjectState = .todo
  ) {
    self.title = title
    self.body = body
    self.deadline = deadline
    self.projectState = projectState
  }
}
