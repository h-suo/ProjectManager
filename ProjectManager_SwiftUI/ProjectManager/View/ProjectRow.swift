//
//  ProjectRow.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import SwiftUI

struct ProjectRow: View {
  
  let project: Project
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(project.title)
        .font(.title3)
      
      Text(project.body)
        .foregroundStyle(.gray)
      
      Text(project.deadline, style: .date)
    }
    .background(.white)
  }
}

#Preview {
  ProjectRow(
    project: Project(
      title: "Test",
      body: "TestBody",
      deadline: Date(),
      state: .doing
    )
  )
}
