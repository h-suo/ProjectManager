//
//  SwiftDatabase.swift
//  ProjectManager
//
//  Created by Erick on 3/19/24.
//

import Combine
import Dependencies
import Foundation
import SwiftData

extension DependencyValues {
  var swiftDatabase: SwiftDatabase {
    get { self[SwiftDatabase.self] }
    set { self[SwiftDatabase.self] = newValue }
  }
}

struct SwiftDatabase: DatabaseProtocol {
  var fetch: () -> AnyPublisher<Result<[Project], DatabaseError>, Never>
  var add: (Project) -> AnyPublisher<Result<Project, DatabaseError>, Never>
  var delete: (Project) -> AnyPublisher<Result<Project, DatabaseError>, Never>
}

extension SwiftDatabase: DependencyKey {
  static var liveValue: SwiftDatabase = Self(
    fetch: {
      do {
        @Dependency(\.database.modelContext) var context
        let projectContext = try context()
        let descriptor = FetchDescriptor<Project>(sortBy: [SortDescriptor(\.deadline)])
        let projects = try projectContext.fetch(descriptor)
        return Just(.success(projects))
          .eraseToAnyPublisher()
      } catch {
        return Just(.failure(.fetchFailed(error)))
          .eraseToAnyPublisher()
      }
    },
    add: { project in
      do {
        @Dependency(\.database.modelContext) var context
        let projectContext = try context()
        projectContext.insert(project)
        return Just(.success(project))
          .eraseToAnyPublisher()
      } catch {
        return Just(.failure(.addFailed(error)))
          .eraseToAnyPublisher()
      }
    },
    delete: { project in
      do {
        @Dependency(\.database.modelContext) var context
        let projectContext = try context()
        projectContext.delete(project)
        return Just(.success(project))
          .eraseToAnyPublisher()
      } catch {
        return Just(.failure(.deleteFailed(error)))
          .eraseToAnyPublisher()
      }
    }
  )
}
