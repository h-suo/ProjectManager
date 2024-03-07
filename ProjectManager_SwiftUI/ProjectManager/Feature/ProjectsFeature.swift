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
    @Presents var addProject: ProjectDetailFeature.State?
  }
  
  enum Action {
    case addButtonTapped
    case addProject(PresentationAction<ProjectDetailFeature.Action>)
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.addProject = ProjectDetailFeature.State(
          project: Project(
            title: "",
            body: "",
            deadline: Date()
          )
        )
        return .none
      case let .addProject(.presented(.delegate(.saveProject(project)))):
        state.projects.append(project)
        return .none
      case .addProject:
        return .none
      }
    }
    .ifLet(\.$addProject, action: \.addProject) {
      ProjectDetailFeature()
    }
  }
}
