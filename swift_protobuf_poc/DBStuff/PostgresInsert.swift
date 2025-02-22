////
////  PostgresInsert.swift
////  swift_protobuf_poc
////
////  Created by Jessy Drouin on 19/02/2025.
////

import Foundation
import PostgresNIO

struct PostgresConfigParameters {
	let username: String
	let password: String
	let host: String
	let port: String
	let database: String

	init(username: String? = nil, password: String? = nil, host: String? = nil, port: String? = nil, database: String? = nil) {
		self.username = ProcessInfo.processInfo.environment["POSTGRES_USERNAME"] ?? "username"
		self.password = ProcessInfo.processInfo.environment["POSTGRES_PASSWORD"] ?? ""
		self.host = ProcessInfo.processInfo.environment["POSTGRES_HOST"] ?? "localhost"
		self.port = ProcessInfo.processInfo.environment["POSTGRES_PORT"] ?? "5432"
		self.database = ProcessInfo.processInfo.environment["POSTGRES_DATABASE"] ?? "default_database"
	}
}

let parameters_postgres = PostgresConfigParameters()




// Init postgres connection
// Create a config
// Création d'une instance


