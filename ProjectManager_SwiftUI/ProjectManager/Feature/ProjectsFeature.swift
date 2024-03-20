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
    case onAppear
    case addButtonTapped
    case projectRowSelected(Project)
    case projectRowDeleted(Project)
    case updateProject(PresentationAction<ProjectDetailFeature.Action>)
  }
  
  @Dependency(\.projectDatabase) private var database
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        do {
          let projects = try database.fetch()
          state.projects = IdentifiedArray(uniqueElements: projects)
        } catch {}
        return .none
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
      case let .projectRowDeleted(project):
        do {
          try database.delete(project)
        } catch {}
        return .run { @MainActor send in
          send(.onAppear, animation: .easeIn)
        }
      case let .updateProject(.presented(.delegate(.saveProject(project)))):
        do {
          try database.add(project)
        } catch {}
        return .run { @MainActor send in
          send(.onAppear, animation: .easeIn)
        }
      case .updateProject:
        return .none
      }
    }
    .ifLet(\.$updateProject, action: \.updateProject) {
      ProjectDetailFeature()
    }
  }
}
