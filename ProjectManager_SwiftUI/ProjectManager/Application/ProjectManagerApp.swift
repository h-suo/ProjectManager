//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Erick on 3/4/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct ProjectManagerApp: App {
  var body: some Scene {
    WindowGroup {
      ProjectsView(
        store: Store(
          initialState: ProjectsFeature.State(),
          reducer: { ProjectsFeature() }
        )
      )
    }
  }
}
