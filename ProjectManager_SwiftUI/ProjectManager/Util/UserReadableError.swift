//
//  UserReadableError.swift
//  ProjectManager
//
//  Created by Erick on 4/3/24.
//

protocol UserReadableError: Error {
  var userMessage: String? { get }
}
