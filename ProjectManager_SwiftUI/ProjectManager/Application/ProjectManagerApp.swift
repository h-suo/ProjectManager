//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Erick on 3/4/24.
//

import ComposableArchitecture
import FirebaseAuth
import FirebaseCore
import SwiftData
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    Auth.auth().signInAnonymously()
    return true
  }
}

@main
struct ProjectManagerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
  @Dependency(\.database) private var databaseService
  private var modelContext: ModelContext {
    do {
      return try self.databaseService.modelContext()
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
