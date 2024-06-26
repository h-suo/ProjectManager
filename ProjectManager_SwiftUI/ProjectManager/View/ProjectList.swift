//
//  ProjectList.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct ProjectList: View {
  @Bindable private var store: StoreOf<ProjectsFeature>
  private let state: ProjectState
  private var filterProjects: [Project] {
    return store.projects.filter { $0.projectState == state }
  }
  
  init(
    store: StoreOf<ProjectsFeature>,
    state: ProjectState
  ) {
    self.store = store
    self.state = state
  }
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        HStack {
          Text(state.rawValue)
            .font(.title)
          
          Text("\(filterProjects.count)")
            .font(.title)
            .foregroundStyle(.white)
            .padding([.all], 8)
            .background(.black)
            .clipShape(Circle())
        }
        .padding([.leading, .top], 16)
        
        Divider()
      }
      .background(Color(.quaternarySystemFill))
      
      List(filterProjects) { project in
        Button {
          store.send(.projectRowSelected(project))
        } label: {
          ProjectRow(project: project)
        }
        .swipeActions {
          Button("Delete", role: .destructive) {
            store.send(.projectRowDeleted(project))
          }
        }
      }
      .animation(.easeIn, value: filterProjects)
      .background(.white)
      .listStyle(PlainListStyle())
    }
  }
}

#Preview {
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: SwiftDataProject.self,
    configurations: configuration
  )
  
  return ProjectList(
    store: Store(
      initialState: ProjectsFeature.State(
        projects: [
          Project(title: "Title", body: "body", deadline: Date()),
          Project(title: "Title", body: "body", deadline: Date()),
          Project(title: "Title", body: "body", deadline: Date()),
          Project(title: "Title", body: "body", deadline: Date()),
          Project(title: "Title", body: "body", deadline: Date()),
          Project(title: "Title", body: "body", deadline: Date()),
        ]
      ),
      reducer: { ProjectsFeature() }
    ),
    state: .todo
  )
  .modelContainer(container)
}
