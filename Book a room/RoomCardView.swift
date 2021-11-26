//
//  RoomCardView.swift
//  Book a room
//
//  Created by Felix Fischer on 25/11/2021.
//

import SwiftUI

struct RoomCardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showBooking: Bool = false
    
    let room: Room
    
    var body: some View {
        VStack(spacing: 15) {
            AsyncImage(
                url: room.thumbnail,
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .transition(.opacity)
                default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            .background(Color.gray)
            .cornerRadius(11)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(room.name ?? "")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("\(room.spots) Spots remaining")
                        .foregroundColor(Color.accentColor)
                }
                Spacer()
                Button {
                    showBooking.toggle()
                } label: {
                    Text("Book!")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color.accentColor)
                        )
                }.disabled(room.spots == 0)

            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .sheet(isPresented: $showBooking) {
            BookingDetails(room: room)
        }
    }
}

struct RoomCardView_Previews: PreviewProvider {
    static var previews: some View {
        let room = Room()
        room.name = "Test Name"
        room.spots = 5
        return RoomCardView(room: room)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(RoomsService())
    }
}
