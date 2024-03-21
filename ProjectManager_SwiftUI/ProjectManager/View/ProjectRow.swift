//
//  ProjectRow.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import SwiftData
import SwiftUI

struct ProjectRow: View {
  
  private let project: Project
  
  init(project: Project) {
    self.project = project
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(project.title)
        .font(.title3)
      
      Text(project.body)
        .foregroundStyle(.gray)
      
      Text(project.deadline, style: .date)
        .foregroundStyle(project.isExceed ? .red : .black)
    }
  }
}

#Preview {
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: Project.self,
    configurations: configuration
  )
  
  return ProjectRow(
    project: Project(
      title: "Test",
      body: "TestBody",
      deadline: Date(),
      projectState: .doing
    )
  )
  .modelContainer(container)
}
