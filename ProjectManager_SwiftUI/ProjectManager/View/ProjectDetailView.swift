//
//  ProjectDetailView.swift
//  ProjectManager
//
//  Created by Erick on 3/7/24.
//

import ComposableArchitecture
import SwiftUI

struct ProjectDetailView: View {
  
  @Bindable 
  private var store: StoreOf<ProjectDetailFeature>
  
  init(store: StoreOf<ProjectDetailFeature>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        TextField("Title", text: $store.project.title.sending(\.setTitle))
          .border(.black, width: 0.5)
          .font(.title3)
        
        DatePicker(
          "",
          selection: $store.project.deadline.sending(\.setDeadLine),
          displayedComponents: .date
        )
          .datePickerStyle(.wheel)
          .frame(width: 0)
        
        TextEditor(text: $store.project.body.sending(\.setBody))
          .border(.black, width: 0.5)
      }
      .padding()
      .navigationTitle("TODO")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(Color(.systemFill), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Cancel") {
            store.send(.cancelButtonTapped)
          }
        }
        
        ToolbarItem {
          Button("Save") {
            store.send(.saveButtonTapped)
          }
        }
      }
    }
  }
}

#Preview {
  ProjectDetailView(
    store: Store(
      initialState: ProjectDetailFeature.State(
        project: Project(
          title: "Title",
          body: "Body",
          deadline: Date()
        )
      ),
      reducer: { ProjectDetailFeature() }
    )
  )
}
