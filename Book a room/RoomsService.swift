//
//  RoomsService.swift
//  Book a room
//
//  Created by Felix Fischer on 25/11/2021.
//

import Foundation
import Combine
import CoreData

class RoomsService: ObservableObject {
    
    @Published var rooms: [Room] = []
    
    private let roomsUrl = URL(string: "https://wetransfer.github.io/rooms.json")!
    private let bookUrl = URL(string: "https://wetransfer.github.io/bookRoom.json")!
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchRooms() async throws {
        let (data, _) = try await URLSession.shared.data(from: roomsUrl)
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
        _ = try decoder.decode(RoomsResult.self, from: data)
        try context.save()
    }
    
    func book(room: Room) async throws -> Bool {
        let (data, _) = try await URLSession.shared.data(from: bookUrl)
        return try JSONDecoder().decode(BookResult.self, from: data).success
    }
}

struct RoomsResult: Decodable {
    let rooms: [Room]
}

struct BookResult: Decodable {
    let success: Bool
}
