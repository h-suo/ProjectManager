//
//  ProjectList.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import ComposableArchitecture
import SwiftUI

struct ProjectList: View {
  
  @Bindable
  private var store: StoreOf<ProjectsFeature>
  private let title: String
  
  init(store: StoreOf<ProjectsFeature>, title: String) {
    self.store = store
    self.title = title
  }
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        HStack {
          Text(title)
            .font(.title)
          
          Text("\(store.projects.count)")
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
      
      List(store.projects) { project in
        Button {
          store.send(.projectRowSelected(project))
        } label: {
          ProjectRow(project: project)
        }
      }
      .background(.white)
      .listStyle(.plain)
    }
  }
}

#Preview {
  ProjectList(
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
    title: "DOING"
  )
}
