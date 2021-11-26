//
//  BookingDetails.swift
//  Book a room
//
//  Created by Felix Fischer on 25/11/2021.
//

import SwiftUI

struct BookingDetails: View {
    @EnvironmentObject var roomsService: RoomsService
    @Environment(\.presentationMode) private var presentationMode
    
    let room: Room
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateTime: Date = Date.now
    
    @State private var showAlert: Bool = false
    @State private var bookingSuccessful:  Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("First name", text: $firstName)
                TextField("Last Name", text: $lastName)
                DatePicker("When:", selection: $dateTime)
            }
            .navigationTitle("Book room \"\(room.name ?? "")\"")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        Task {
                            guard let success = try? await roomsService.book(room: room) else { return }
                            if success { room.spots -= 1 }
                            bookingSuccessful = success
                            showAlert = true
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
            .alert(bookingSuccessful ? "Booking successful" : "Booking not successful", isPresented: $showAlert, actions: {
                Button {
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("OK")
                }

            })
        }
    }
}

struct BookingDetails_Previews: PreviewProvider {
    static var previews: some View {
        let room = Room()
        room.name = "Test Name"
        room.spots = 5
        return BookingDetails(room: room)
    }
}
