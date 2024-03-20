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
    @Presents var alert: AlertState<Action.Alert>?
    @Presents var updateProject: ProjectDetailFeature.State?
  }
  
  enum Action {
    case onAppear
    case addButtonTapped
    case projectRowSelected(Project)
    case projectRowDeleted(Project)
    case alert(PresentationAction<Alert>)
    case updateProject(PresentationAction<ProjectDetailFeature.Action>)
    
    enum Alert: Equatable {
      case confirmError
    }
  }
  
  @Dependency(\.projectDatabase) private var database
  
  private func errorAlertState(_ error: Error) -> AlertState<Action.Alert> {
    return AlertState {
      TextState(error.localizedDescription)
    } actions: {
      ButtonState(role: .cancel, action: .confirmError) {
        TextState("OK")
      }
    }
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        do {
          let projects = try database.fetch()
          state.projects = IdentifiedArray(uniqueElements: projects)
        } catch {
          state.alert = errorAlertState(error)
        }
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
        } catch {
          state.alert = errorAlertState(error)
        }
        return .run { @MainActor send in
          send(.onAppear, animation: .easeIn)
        }
      case let .updateProject(.presented(.delegate(.saveProject(project)))):
        do {
          try database.add(project)
        } catch {
          state.alert = errorAlertState(error)
        }
        return .run { @MainActor send in
          send(.onAppear, animation: .easeIn)
        }
      case .updateProject:
        return .none
      case .alert(.presented(.confirmError)):
        state.alert = nil
        return .none
      case .alert:
        return .none
      }
    }
    .ifLet(\.$updateProject, action: \.updateProject) {
      ProjectDetailFeature()
    }
    .ifLet(\.$alert, action: \.alert)
  }
}
