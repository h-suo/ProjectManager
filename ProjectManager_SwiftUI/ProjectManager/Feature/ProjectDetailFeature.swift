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
  
  @ObservableState
  struct State: Equatable {
    var project: Project
  }
  
  enum Action {
    case cancelButtonTapped
    case saveButtonTapped
    case setTitle(String)
    case setBody(String)
    case setDeadLine(Date)
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .none
      case .saveButtonTapped:
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
      }
    }
  }
}
