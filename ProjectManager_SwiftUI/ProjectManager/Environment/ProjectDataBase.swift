//
//  ProjectDataBase.swift
//  ProjectManager
//
//  Created by Erick on 3/19/24.
//

import Dependencies
import Foundation
import SwiftData

extension DependencyValues {
  var projectDatabase: ProjectDatabase {
    get { self[ProjectDatabase.self] }
    set { self[ProjectDatabase.self] = newValue }
  }
}

struct ProjectDatabase {
  var fetch: () throws -> [Project]
  var add: (Project) throws -> Void
  var delete: (Project) throws -> Void
  
  enum DatabaseError: Error {
    case addFailed
    case deleteFailed
  }
}

extension ProjectDatabase: DependencyKey {
  static var liveValue: ProjectDatabase = Self(
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
