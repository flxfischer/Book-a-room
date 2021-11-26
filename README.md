# Book-a-room

## Implementation Details
I decided to write this App with SwiftUI and async/await with a straight forward architecture. 
The data is downloaded and saved into a CoreData database. The UI gets updated on database changes. 
Because of that the rooms are available offline, except for the images. 

### Room.swift
This is the NSManagedObject class which needs to be Decodable. CoreData uses its "Category/Extension" functionality to add managed properties. 

### Book_a_roomApp.swift
Main File where the first view is loaded and the environment variables for the coredata context and the service get attached. This file should be renamed. 

### ContentView.swift
Main view which contains the LazyVStack. Its also handles the loading state when the rooms get fetched from the service. I would want to add pull to refresh, but its not easy doable for LasyVStack in SwiftUI right now. So I decided to leave it out for now.

### Persistence.swift
CoreData persistentContainer. I add "NSMergeByPropertyObjectTrumpMergePolicy" as merge policy to prevent duplicate rooms in the database when I reload. 

### RoomCardView.swift
The SwiftUI CardView where I used the new AsyncImage API.

### RoomsService.swift
Service class using async/await

### BookingDetails.swift
Form UI. When you click on the "Book!" button on a card, it opens in a sheet. You can enter your name and a date and time you want to book the room. Because I have no API for that, this is a dummy functionality.

There are no UnitTest in the project, because in my opinion there is nothing to test. Its just UI with CoreData. No calcultation are done.
