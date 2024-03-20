//
//  ProjectDetailFeature.swift
//  ProjectManager
//
//  Created by Erick on 3/7/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ProjectDetailFeature {
  
  @Dependency(\.dismiss) var dismiss
  
  @ObservableState
  struct State: Equatable {
    var project: Project
  }
  
  enum Action {
    case cancelButtonTapped
    case saveButtonTapped
    case delegate(Delegate)
    case setTitle(String)
    case setBody(String)
    case setDeadLine(Date)
    case setProjectState(ProjectState)
    
    enum Delegate: Equatable {
      case saveProject(Project)
    }
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .run { _ in await self.dismiss() }
      case .saveButtonTapped:
        return .run { [project = state.project] send in
          await send(.delegate(.saveProject(project)))
          await self.dismiss()
        }
      case .delegate:
        return .none
      case let .setTitle(title):
        state.project.title = title
        return .none
      case let .setBody(body):
        state.project.body = body
        return .none
      case let .setDeadLine(deadLine):
        state.project.deadline = deadLine
        return .none
      case let .setProjectState(projectState):
        state.project.projectState = projectState
        return .none
      }
    }
  }
}
