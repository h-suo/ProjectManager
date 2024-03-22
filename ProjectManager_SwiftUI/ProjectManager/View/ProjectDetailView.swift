//
//  ProjectDetailView.swift
//  ProjectManager
//
//  Created by Erick on 3/7/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct ProjectDetailView: View {
  @Bindable private var store: StoreOf<ProjectDetailFeature>
  
  init(store: StoreOf<ProjectDetailFeature>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        Picker("", selection: $store.project.projectState.sending(\.setProjectState)) {
          ForEach(ProjectState.allCases, id: \.self) { state in
            Text(state.rawValue)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding([.top, .bottom], 16)
        .disabled(store.isDisabled)
        
        TextField("Title", text: $store.project.title.sending(\.setTitle))
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.title2)
          .disabled(store.isDisabled)
        
        DatePicker(
          "",
          selection: $store.project.deadline.sending(\.setDeadLine),
          displayedComponents: .date
        )
        .datePickerStyle(WheelDatePickerStyle())
        .frame(width: 0)
        .disabled(store.isDisabled)
        
        TextEditor(text: $store.project.body.sending(\.setBody))
          .overlay {
            RoundedRectangle(cornerRadius: 8)
              .stroke(.placeholder, lineWidth: 0.5)
          }
          .disabled(store.isDisabled)
      }
      .padding()
      .navigationTitle("Add Project")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(Color(.systemFill), for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          if store.isNewProject {
            Button("Cancel") {
              store.send(.cancelButtonTapped)
            }
          } else {
            Button("Edit") {
              store.send(.editButtonTapped)
            }
            .disabled(!store.isDisabled)
          }
        }
        
        ToolbarItem {
          Button("done") {
            store.send(.doneButtonTapped)
          }
        }
      }
    }
  }
}

#Preview {
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: Project.self,
    configurations: configuration
  )
  
  return ProjectDetailView(
    store: Store(
      initialState: ProjectDetailFeature.State(
        project: Project(
          title: "Test",
          body: "TestBody",
          deadline: Date(),
          projectState: .doing
        ),
        isNewProject: false
      ),
      reducer: { ProjectDetailFeature() }
    )
  )
  .modelContainer(container)
}
