//
//  ProjectsFeature.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ProjectsFeature {
  
  @ObservableState
  struct State: Equatable {
    var projects: IdentifiedArrayOf<Project> = []
  }
  
  enum Action {
    case addButtonTapped
    case selectProject
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        return .none
      case .selectProject:
        return .none
      }
    }
  }
}
