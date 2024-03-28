//
//  SwiftDatabase.swift
//  ProjectManager
//
//  Created by Erick on 3/19/24.
//

import Dependencies
import Foundation
import SwiftData

extension DependencyValues {
  var swiftDatabase: SwiftDatabase {
    get { self[SwiftDatabase.self] }
    set { self[SwiftDatabase.self] = newValue }
  }
}

struct SwiftDatabase {
  var fetch: () throws -> [Project]
  var add: (Project) throws -> Void
  var delete: (Project) throws -> Void
  
  enum DatabaseError: LocalizedError {
    case addFailed
    case deleteFailed
    
    var errorDescription: String? {
      switch self {
      case .addFailed:
        return "Addition failed."
      case .deleteFailed:
        return "Deletion failed."
      }
    }
  }
}

extension SwiftDatabase: DependencyKey {
  static var liveValue: SwiftDatabase = Self(
    fetch: {
      do {
        @Dependency(\.database.context) var context
        let projectContext = try context()
        let descriptor = FetchDescriptor<Project>(sortBy: [SortDescriptor(\.deadline)])
        return try projectContext.fetch(descriptor)
      } catch {
        return []
      }
    },
    add: { project in
      do {
        @Dependency(\.database.context) var context
        let projectContext = try context()
        projectContext.insert(project)
      } catch {
        throw DatabaseError.addFailed
      }
    },
    delete: { project in
      do {
        @Dependency(\.database.context) var context
        let projectContext = try context()
        projectContext.delete(project)
      } catch {
        throw DatabaseError.deleteFailed
      }
    }
  )
}
