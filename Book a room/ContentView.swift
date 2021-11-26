//
//  ContentView.swift
//  Book a room
//
//  Created by Felix Fischer on 25/11/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @EnvironmentObject var roomsService: RoomsService
    
    @FetchRequest<Room>(entity: Room.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Room.name, ascending: true)])
    
    private var rooms: FetchedResults<Room>
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isLoading {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(rooms) { room in
                            RoomCardView(room: room)
                        }
                    }
                }
            }
            .navigationTitle("Book a room")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            isLoading = true
            Task {
                try? await roomsService.fetchRooms()
                isLoading = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(RoomsService())
.previewInterfaceOrientation(.landscapeLeft)
        
    }
}
