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
        Picker("", selection: $store.project.state.sending(\.setState)) {
          ForEach(ProjectState.allCases, id: \.self) { state in
            Text(state.rawValue)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding([.top, .bottom], 16)
        
        TextField("Title", text: $store.project.title.sending(\.setTitle))
          .textFieldStyle(.roundedBorder)
          .font(.title3)
        
        DatePicker(
          "",
          selection: $store.project.deadline.sending(\.setDeadLine),
          displayedComponents: .date
        )
        .datePickerStyle(.wheel)
        .frame(width: 0)
        
        TextEditor(text: $store.project.body.sending(\.setBody))
          .overlay {
            RoundedRectangle(cornerRadius: 8)
              .stroke(.placeholder, lineWidth: 0.5)
          }
      }
      .padding()
      .navigationTitle("Add Project")
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
