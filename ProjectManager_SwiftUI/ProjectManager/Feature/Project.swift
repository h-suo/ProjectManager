//
//  Project.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import Foundation

enum ProjectState: String, CaseIterable {
  case todo = "TODO"
  case doing = "DOING"
  case done = "DONE"
}

struct Project: Equatable, Identifiable {
  let id: UUID
  var title: String
  var body: String
  var deadline: Date
  var state: ProjectState
  var isExceed: Bool { Calendar.compareDate(deadline) ?? false }
  
  init(
    id: UUID = UUID(),
    title: String,
    body: String,
    deadline: Date,
    state: ProjectState = .todo
  ) {
    self.id = id
    self.title = title
    self.body = body
    self.deadline = deadline
    self.state = state
  }
}
