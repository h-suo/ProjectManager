//
//  ProjectList.swift
//  ProjectManager
//
//  Created by Erick on 3/5/24.
//

import IdentifiedCollections
import SwiftUI

struct ProjectList: View {
  
  let title: String
  let projects: IdentifiedArrayOf<Project>
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        HStack {
          Text(title)
            .font(.title)
          
          Text("\(projects.count)")
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
      
      List(projects) { project in
        ProjectRow(project: project)
      }
      .background(.white)
      .listStyle(.plain)
    }
  }
}

#Preview {
  ProjectList(
    title: "DOING",
    projects: [
      Project(title: "test", body: "test", deadline: Date(), state: .doing),
      Project(title: "test", body: "test", deadline: Date(), state: .doing),
      Project(title: "test", body: "test", deadline: Date(), state: .doing),
      Project(title: "test", body: "test", deadline: Date(), state: .doing),
      Project(title: "test", body: "test", deadline: Date(), state: .doing),
      Project(title: "test", body: "test", deadline: Date(), state: .doing),
    ]
  )
}
