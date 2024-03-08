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
    @Presents var updateProject: ProjectDetailFeature.State?
  }
  
  enum Action {
    case addButtonTapped
    case projectRowSelected(Project)
    case projectRowDeleted(Project.ID)
    case updateProject(PresentationAction<ProjectDetailFeature.Action>)
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.updateProject = ProjectDetailFeature.State(
          project: Project(
            title: "",
            body: "",
            deadline: Date()
          )
        )
        return .none
      case let .projectRowSelected(project):
        state.updateProject = ProjectDetailFeature.State(
          project: project
        )
        return .none
      case let .projectRowDeleted(id):
        state.projects.remove(id: id)
        return .none
      case let .updateProject(.presented(.delegate(.saveProject(project)))):
        state.projects.updateOrAppend(project)
        return .none
      case .updateProject:
        return .none
      }
    }
    .ifLet(\.$updateProject, action: \.updateProject) {
      ProjectDetailFeature()
    }
  }
}
