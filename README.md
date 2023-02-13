# nasa_gallery
NASA APOD - iOS App 

Quick notes: 
1. Developed a solution using SwiftUI on Xcode 14.2.
2. Implemented a caching mechanism using NSCache for HTTP requests to reduce unnecessary network calls. However, the NSCache only stores data in memory and is not persistent if the app is terminated.
3. Included a 'Reload from Cache' feature to test the effectiveness of the cache.
4. Due to uncertainty about the release time of the daily photo from NASA, the solution was designed to load the previous day's image to prevent service failure. This was achieved through the use of a date extension that provides the previous day's date.
