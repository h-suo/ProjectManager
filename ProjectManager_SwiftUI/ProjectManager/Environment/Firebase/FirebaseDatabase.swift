//
//  FirebaseDatabase.swift
//  ProjectManager
//
//  Created by Erick on 3/29/24.
//

import Combine
import Dependencies
import FirebaseFirestore

extension DependencyValues {
  var firebaseDatabase: FirebaseDatabase {
    get { self[FirebaseDatabase.self] }
    set { self[FirebaseDatabase.self] = newValue }
  }
}

struct FirebaseDatabase: DatabaseProtocol {
  var fetch: () -> AnyPublisher<Result<[Project], DatabaseError>, Never>
  var add: (Project) -> AnyPublisher<Result<Project, DatabaseError>, Never>
  var delete: (Project) -> AnyPublisher<Result<Project, DatabaseError>, Never>
}

extension FirebaseDatabase: DependencyKey {
  static var liveValue: FirebaseDatabase = Self(
    fetch: {
      return Future<Result<[Project], DatabaseError>, Never> { promise in
        @Dependency(\.database.firestore) var firestore
        let db = firestore()
        db.collection("Project").order(by: "deadline").getDocuments { snapshot, error in
          if let error {
            promise(.success(.failure(.fetchFailed(error))))
          } else if let snapshot {
            let projects = snapshot.documents
              .compactMap { try? $0.data(as: FirebaseProject.self).convertToProject() }
            promise(.success(.success(projects)))
          }
        }
      }
      .eraseToAnyPublisher()
    },
    add: { project in
      return Future<Result<Project, DatabaseError>, Never> { promise in
        @Dependency(\.database.firestore) var firestore
        let db = firestore()
        do {
          try db.collection("Project").document(project.id.uuidString).setData(
            from: project.convertToFirebaseProject()
          ) { error in
            if let error {
              promise(.success(.failure(.addFailed(error))))
            } else {
              promise(.success(.success(project)))
            }
          }
        } catch {
          promise(.success(.failure(.addFailed(error))))
        }
      }
      .eraseToAnyPublisher()
    },
    delete: { project in
      return Future<Result<Project, DatabaseError>, Never> { promise in
        @Dependency(\.database.firestore) var firestore
        let db = firestore()
        db.collection("Project").document(project.id.uuidString).delete { error in
          if let error {
            promise(.success(.failure(.deleteFailed(error))))
          } else {
            promise(.success(.success(project)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  )
}
