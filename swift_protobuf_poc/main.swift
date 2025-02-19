//
//  main.swift
//  swift_protobuf_poc
//
//  Created by Jessy Drouin on 19/02/2025.
//

import Foundation
import SwiftProtobuf

// Exemple de données
var user = User()
user.id = 1
user.name = "Alice"
user.email = "alice@example.com"

// Sérialisation en Data
let userData = try! user.serializedData()
print("Données sérialisées : \(userData)")

if let decodedUser = try? User(serializedBytes: userData) {
	print("User décodé : \(decodedUser.name), Email: \(decodedUser.email)")
}

// =================================================================================
// .
//==================================================================================
// Exemple
let users = (1...1000).map { id in
	var user = User()
	user.id = Int32(id)
	user.name = "User \(id)"
	user.email = "user\(id)@example.com"
	return user
}

Task {
	await serializeUsersConcurrently(users: users)
}
