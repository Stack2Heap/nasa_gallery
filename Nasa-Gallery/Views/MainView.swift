import SwiftUI

struct MainView: View {
        
    var appPrefs = AppPrefs()
    
    var body: some View {
        TabView {
            APODView()
                .tabItem {
                    Label("APOD", systemImage: "globe")
                }
                .environmentObject(appPrefs)
        }
        .accentColor(AppConstants.blueColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
