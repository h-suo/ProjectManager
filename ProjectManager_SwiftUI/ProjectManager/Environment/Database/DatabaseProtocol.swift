//
//  DatabaseProtocol.swift
//  ProjectManager
//
//  Created by Erick on 3/29/24.
//

import Combine
import Foundation

protocol DatabaseProtocol {
  var fetch: () -> AnyPublisher<Result<[Project], DatabaseError>, Never> { get }
  var add: (Project) -> AnyPublisher<Result<Project, DatabaseError>, Never> { get }
  var delete: (Project) -> AnyPublisher<Result<Project, DatabaseError>, Never> { get }
}

enum DatabaseError: LocalizedError, UserReadableError {
  case fetchFailed(Error)
  case addFailed(Error)
  case deleteFailed(Error)
  
  var errorDescription: String? {
    switch self {
    case let .fetchFailed(error):
      return "Fetch failed.: \(error.localizedDescription)"
    case let .addFailed(error):
      return "Addition failed.: \(error.localizedDescription)"
    case let .deleteFailed(error):
      return "Deletion failed.: \(error.localizedDescription)"
    }
  }
  
  var userMessage: String? {
    return "The operation failed.\n Please check your internet connection and try again."
  }
}
