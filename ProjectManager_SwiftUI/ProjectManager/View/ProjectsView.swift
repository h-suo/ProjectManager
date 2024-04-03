//
//  ProjectsView.swift
//  ProjectManager
//
//  Created by Erick on 3/4/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct ProjectsView: View {
  @Bindable private var store: StoreOf<ProjectsFeature>
  
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
    .onAppear {
      store.send(.onAppear)
    }
    .sheet(
      item: $store.scope(state: \.updateProject, action: \.updateProject)
    ) { projectDetailStore in
      ProjectDetailView(store: projectDetailStore)
    }
    .alert($store.scope(state: \.alert, action: \.alert))
  }
}

#Preview {
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: SwiftDataProject.self,
    configurations: configuration
  )
  
  return ProjectsView(
    store: Store(
      initialState: ProjectsFeature.State(),
      reducer: { ProjectsFeature() }
    )
  )
  .modelContainer(container)
}
