//
//  SerializationUtils.swift
//  swift_protobuf_poc
//
//  Created by Jessy Drouin on 19/02/2025.
//

import Foundation
import SwiftProtobuf

// =================================================================================
// .
//==================================================================================
func serializeUsersConcurrently(users: [User]) async {
	await withTaskGroup(of: Data.self) { group in
		for user in users {
			group.addTask {
				return try! user.serializedData()
			}
		}

		for await data in group {
			print("Sérialisation réussie, taille: \(data.count) octets")
		}
	}
}

// =================================================================================
// .
//==================================================================================
func benchmarkSerialization<T: SwiftProtobuf.Message>(object: T) {
	let start = Date()
	let data = try! object.serializedData()
	let duration = Date().timeIntervalSince(start)

	print("Taille des données: \(data.count) octets")
	print("Temps de sérialisation: \(duration) sec")
}
