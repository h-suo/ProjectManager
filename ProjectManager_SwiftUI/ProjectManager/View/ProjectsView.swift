//
//  ProjectsView.swift
//  ProjectManager
//
//  Created by Erick on 3/4/24.
//

import ComposableArchitecture
import SwiftUI

struct ProjectsView: View {
  
  let store: StoreOf<ProjectsFeature>
  
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
          Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(systemName: "plus")
          })
        }
      }
    }
  }
}

#Preview {
  ProjectsView(
    store: Store(
      initialState: ProjectsFeature.State(
        projects: [
          Project(title: "Title", body: "body", deadline: Date(), state: .toDo),
          Project(title: "Title", body: "body", deadline: Date(), state: .toDo),
          Project(title: "Title", body: "body", deadline: Date(), state: .toDo),
          Project(title: "Title", body: "body", deadline: Date(), state: .toDo),
          Project(title: "Title", body: "body", deadline: Date(), state: .toDo),
          Project(title: "Title", body: "body", deadline: Date(), state: .toDo),
        ]
      ),
      reducer: { ProjectsFeature() }
    )
  )
}
