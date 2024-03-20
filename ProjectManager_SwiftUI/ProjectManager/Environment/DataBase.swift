//
//  DataBase.swift
//  ProjectManager
//
//  Created by Erick on 3/19/24.
//

import SwiftData
import Dependencies

extension DependencyValues {
  var database: Database {
    get { self[Database.self] }
    set { self[Database.self] = newValue }
  }
}

fileprivate let modelContext: ModelContext = {
  do {
    let container = try ModelContainer(for: Project.self)
    return ModelContext(container)
  } catch {
    fatalError("Container creation failed.")
  }
}()

struct Database {
  var context: () throws -> ModelContext
}

extension Database: DependencyKey {
  static let liveValue = Self(
    context: { modelContext }
  )
}
