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
    var projects: [Project] = []
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
    case fetchProjects(Result<[Project], DatabaseError>)
    case handleProject(Result<Project, DatabaseError>)
    
    enum Alert: Equatable {
      case confirmError
    }
  }
  
  @Dependency(\.swiftDatabase) private var swiftDatabase
  @Dependency(\.firebaseDatabase) private var firebaseDatabase
  
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
        return .publisher {
          swiftDatabase.fetch()
            .merge(with: firebaseDatabase.fetch())
            .receive(on: DispatchQueue.main)
            .map(Action.fetchProjects)
        }
      case .addButtonTapped:
        state.updateProject = ProjectDetailFeature.State(
          project: Project(
            title: "",
            body: "",
            deadline: Date()
          ),
          isNewProject: true
        )
        return .none
      case let .projectRowSelected(project):
        state.updateProject = ProjectDetailFeature.State(
          project: project,
          isNewProject: false
        )
        return .none
      case let .projectRowDeleted(project):
        return .publisher {
          swiftDatabase.delete(project)
            .merge(with: firebaseDatabase.delete(project))
            .receive(on: DispatchQueue.main)
            .map(Action.handleProject)
        }
      case .alert(.presented(.confirmError)):
        state.alert = nil
        return .none
      case .alert:
        return .none
      case let .updateProject(.presented(.delegate(.saveProject(project)))):
        return .publisher {
          swiftDatabase.add(project)
            .merge(with: firebaseDatabase.add(project))
            .receive(on: DispatchQueue.main)
            .map(Action.handleProject)
        }
      case .updateProject:
        return .none
      case let .fetchProjects(result):
        switch result {
        case let .success(projects):
          state.projects = projects
          return .none
        case let .failure(error):
          state.alert = errorAlertState(error)
          return .none
        }
      case let .handleProject(result):
        switch result {
        case .success(_):
          return .send(.onAppear)
        case let .failure(error):
          state.alert = errorAlertState(error)
          return .none
        }
      }
    }
    .ifLet(\.$updateProject, action: \.updateProject) {
      ProjectDetailFeature()
    }
    .ifLet(\.$alert, action: \.alert)
  }
}
