////
////  PostgresInsert.swift
////  swift_protobuf_poc
////
////  Created by Jessy Drouin on 19/02/2025.
////
//
//import Foundation
//import PostgresNIO
//
//
//let insertQuery = "INSERT INTO users (id, data) VALUES ($1, $2)"
//let parameters: [PostgresData] = [
//	.int(user.id),
//	.bytea(userData) // Stocker le Data binaire ici
//]
//
//// Envoi vers PostgreSQL
//try await postgresClient.query(insertQuery, parameters)
