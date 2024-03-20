//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Erick on 3/4/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

@main
struct ProjectManagerApp: App {
  @Dependency(\.database) var databaseService
  var modelContext: ModelContext {
    do {
      return try self.databaseService.context()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  var body: some Scene {
    WindowGroup {
      ProjectsView(
        store: Store(
          initialState: ProjectsFeature.State(),
          reducer: { ProjectsFeature() }
        )
      )
      .modelContext(modelContext)
    }
  }
}
