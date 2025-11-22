# **Picsum_Wheather_App**

### **Features**
- Fetch and display images from Picsum.photos with infinite scroll and image caching using Kingfisher.
- Map integration using Google Maps SDK added via Swift Package Manager.
- Markers on the map show thumbnails of Picsum images.
- On tapping a marker, current weather data for that location is fetched in real-time from Open-Meteo API and displayed.
- Fully supports portrait and landscape orientations.
- Clean MVVM architecture with use-case separation and async/await concurrency.
- Unit tests cover API decoding, pagination logic, and weather fetching with mocks.
- Graceful error handling and UI states (loading, empty, error).
- Google Maps API key management via Info.plist.
---

### **Requirements**
- iOS 16 or later
- Xcode 14 or later
- Swift 5.7+
- Swift Package Manager for dependencies (Kingfisher, Google Maps SDK)
---

### **Installation**
- Clone the repository.
- Open the .xcodeproj file.
- Ensure you add your Google Maps API key in Info.plist under GoogleMapsAPIKey.
- Build and run on an iOS device or simulator with internet access.
___

### **Usage**
- Scroll the image grid to load more Picsum images seamlessly.
- Switch to the Map tab to see image locations visualized as markers.
- Tap any marker to view detailed current weather info for that location.
___

### **Testing**
- Unit tests are located in the Tests target.
- Run all tests with Cmd + U in Xcode.
- Tests verify model decoding, pagination correctness, and weather fetching logic.
___

### **Architecture & Design**
- MVVM pattern separates Views, ViewModels, and Services.
- Kingfisher handles efficient async image downloading and caching.
- Google Maps displayed through UIViewRepresentable wrapper.
- Weather data loaded asynchronously with Swift concurrency.
- Protocol-based service abstractions enable easy mocking and testing.
- Error states presented with user-friendly messages in UI.
