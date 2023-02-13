import SwiftUI

struct APODView: View {

    private let viewModel = SpaceViewModel()

    @State private var currAPOD: APODInstance = APODInstance.loading
    @State private var currImage: UIImage? = nil

    @State private var imageScale : CGFloat = 1
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            Text(currAPOD.title)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .textSelection(.enabled)
                .padding(.top)
            if currImage == nil {
                Spacer()
                Image(uiImage: UIImage(named: AppConstants.defaultNASALogo)!)
                    .resizable()
                    .scaledToFit()
                Spacer()
                ProgressView()
                Spacer()
            } else {
                if currAPOD.media_type == "image" {
                    Image(uiImage: currImage!)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect((imageScale > 1) ? imageScale : 1)
                        .gesture(
                            MagnificationGesture()
                                .onChanged( { (value) in
                                    imageScale = value
                                })
                                .onEnded({ (_) in
                                    withAnimation((.spring())) {
                                        imageScale = 1
                                    }
                                })
                                .simultaneously(with: TapGesture(count: 2).onEnded({ (_) in
                                    withAnimation((.spring())) {
                                        imageScale = (imageScale > 1) ? 1 : 4
                                    }
                                }))
                        )
                }
            }
            ScrollView {
                Text(currAPOD.explanation)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.center)
                    .textSelection(.enabled)
            }
            Button("Reload from Cache") {
                Task {
                    (currAPOD, currImage) = try await viewModel.fetchImageOfTheDay()
                }
            }
            .navigationTitle("Astronomic Picture Of the Day")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(AppConstants.blueColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                if currAPOD.media_type == "image" {
                    ToolbarItem(placement: .navigationBarTrailing) {
                    }
                }
            }
            .onAppear {
                UITabBar.appearance().barTintColor = .red
                Task {
                    (currAPOD, currImage) = try await viewModel.fetchImageOfTheDay()
                }
            }
        }
    }
}

struct APODView_Previews: PreviewProvider {
    static var previews: some View {
        APODView()
            .environmentObject(AppPrefs())
    }
}
