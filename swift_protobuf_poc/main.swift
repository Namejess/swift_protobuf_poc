//
//  main.swift
//  swift_protobuf_poc
//
//  Created by Jessy Drouin on 19/02/2025.
//
import Foundation
import SwiftProtobuf
import PostgresNIO

// =================================================================================
// POSTGRES CONNECTION
//==================================================================================

// Création du client
let config = PostgresClient.Configuration(
	host: parameters_postgres.host,
	username: parameters_postgres.username,
	password: parameters_postgres.password,
	database: parameters_postgres.database,
	tls: .disable
)

let client = PostgresClient(configuration: config)

// Exécution asynchrone du client PostgreSQL
try await withThrowingTaskGroup(of: Void.self) { taskGroup in
	taskGroup.addTask {
		await client.run() // Important! pour garder la connexion active
	}

	// Création de la table `users` si elle n'existe pas
	try await client.query("""
	CREATE TABLE IF NOT EXISTS "users" (
		id SERIAL PRIMARY KEY,
		data BYTEA
	)
	""")

	// Log vérification création de la table
	print("Table users créée avec succès !")

	// Exemple de données
	var user = User()
	user.id = 1
	user.name = "Jessy"
	user.email = "jessy@protonmail.com"

	// Sérialisation en Data
	let userData = try! user.serializedData()
	print("Données sérialisées : \(userData)")

	if let decodedUser = try? User(serializedBytes: userData) {
		print("Test User décodé : \(decodedUser.name), Email: \(decodedUser.email)")
	}

	do {
		// Envoi de la requête vers PostgreSQL avec les valeurs interpolées
		try await client.query("""
		INSERT INTO users (data) VALUES (\(userData))
		""")

		print("Insertion réussie !")

		// Vérification de l'insertion
		let rows = try await client.query("""
		SELECT id, data FROM users ORDER BY id DESC LIMIT 1
		""")

		for try await (id, data) in rows.decode((Int, ByteBuffer).self) {
			let fetchedUserData = Data(buffer: data)
			if let fetchedUser = try? User(serializedBytes: fetchedUserData) {
				print("Utilisateur récupéré: ID \(id), Nom: \(fetchedUser.name), Email: \(fetchedUser.email)")
			}
		}
	} catch {
		print("Erreur lors de l'insertion ou de la récupération dans la base de données : \(error)")
	}

	// Fermeture propre du client PostgreSQL
	taskGroup.cancelAll()
}
// =================================================================================
// .
//==================================================================================
//// Exemple
//let users = (1...1000).map { id in
//	var user = User()
//	user.id = Int32(id)
//	user.name = "User \(id)"
//	user.email = "user\(id)@example.com"
//	return user
//}
//
//Task {
//	await serializeUsersConcurrently(users: users)
//}
