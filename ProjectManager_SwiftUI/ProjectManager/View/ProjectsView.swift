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
  private var store: StoreOf<ProjectsFeature>
  
  init(store: StoreOf<ProjectsFeature>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStack {
      HStack {
        ProjectList(
          store: store,
          state: .todo
        )
        
        ProjectList(
          store: store,
          state: .doing
        )
                
        ProjectList(
          store: store,
          state: .done
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
      item: $store.scope(state: \.updateProject, action: \.updateProject)
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
          Project(title: "Title", body: "body", deadline: Date(), projectState: .doing),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .doing),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .doing),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .doing),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .doing),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .done),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .done),
          Project(title: "Title", body: "body", deadline: Date(), projectState: .done),
        ]
      ),
      reducer: { ProjectsFeature() }
    )
  )
}
