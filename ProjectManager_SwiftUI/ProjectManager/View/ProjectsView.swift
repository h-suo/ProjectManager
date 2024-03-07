//
//  ProjectsView.swift
//  ProjectManager
//
//  Created by Erick on 3/4/24.
//

import ComposableArchitecture
import SwiftUI

struct ProjectsView: View {
  
  @Bindable
  var store: StoreOf<ProjectsFeature>
  
  var body: some View {
    NavigationStack {
      HStack {
        ProjectList(
          title: "TODO",
          projects: store.projects
        )
        
        ProjectList(
          title: "DOING",
          projects: store.projects
        )
                
        ProjectList(
          title: "DONE",
          projects: store.projects
        )
      }
      .background(Color(.quaternarySystemFill))
      .navigationTitle("ProjectManager")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(Color(.systemFill), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbar {
        ToolbarItem {
          Button {
            store.send(.addButtonTapped)
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .sheet(
      item: $store.scope(state: \.addProject, action: \.addProject)
    ) { projectDetailStore in
      ProjectDetailView(store: projectDetailStore)
    }
  }
}

#Preview {
  ProjectsView(
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
    )
  )
}
