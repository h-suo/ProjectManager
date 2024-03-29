//
//  Database.swift
//  ProjectManager
//
//  Created by Erick on 3/19/24.
//

import Dependencies
import SwiftData

extension DependencyValues {
  var database: Database {
    get { self[Database.self] }
    set { self[Database.self] = newValue }
  }
}

fileprivate let myModelContext: ModelContext = {
  do {
    let container = try ModelContainer(for: Project.self)
    return ModelContext(container)
  } catch {
    fatalError("Container creation failed.")
  }
}()

struct Database {
  var modelContext: () throws -> ModelContext
}

extension Database: DependencyKey {
  static let liveValue = Self(
    modelContext: { myModelContext },
  )
}
