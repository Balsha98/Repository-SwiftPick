import SwiftUI

public struct PodcastScrollView: View {
    public var rewardsPoints: Int
    public var podcasts: Podcasts?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Podcast")
                    .font(.title)
                    .fontWeight(.bold)
                //Text
                
                Spacer()
                
                Image(systemName: "play.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.primary)
                //Image
            }//HStack
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    if let podcasts = self.podcasts {
                        ForEach(podcasts.data) { podcast in
                            ZStack {
                                if podcast.unlocksAt > self.rewardsPoints {
                                    ZStack {
                                        Text("Unlocks at \(podcast.unlocksAt) reward points.")
                                            .font(.callout)
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .italic()
                                        //Text
                                        
                                        VStack {
                                            Spacer()
                                            
                                            HStack {
                                                Spacer()
                                                
                                                Image(systemName: "lock.fill")
                                                    .padding()
                                                    .foregroundStyle(Color.primary)
                                                    .background(.white)
                                                    .clipShape(Circle())
                                                    .shadow(
                                                        color: .black.opacity(0.2),
                                                        radius: 4, x: 0, y: 4
                                                    )//shadow
                                                //Image
                                            }//HStack
                                        }//VStack
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .padding()
                                    }//VStack
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.black.opacity(0.8))
                                    .zIndex(2)
                                } else {
                                    VStack {
                                        Spacer()
                                        
                                        HStack {
                                            Spacer()
                                            
                                            Button {
                                                if let url = URL(string: podcast.link) {
                                                    UIApplication.shared.open(url)
                                                }//if
                                            } label: {
                                                Image(systemName: "play.fill")
                                                    .padding()
                                                    .foregroundStyle(.white)
                                                    .background(Color.primary)
                                                    .clipShape(Circle())
                                                    .shadow(
                                                        color: .black.opacity(0.2),
                                                        radius: 4, x: 0, y: 4
                                                    )//shadow
                                                //Image
                                            }//Button
                                        }//HStack
                                    }//VStack
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding()
                                    .background(.black.opacity(0.2))
                                    .zIndex(2)
                                }//if
                                
                                if let url = URL(string: podcast.thumbnail) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .containerRelativeFrame(.horizontal)
                                        //Image
                                    } placeholder: {
                                        Image("logo.valuetainment.landscape.original")
                                            .resizable()
                                            .scaledToFit()
                                            .containerRelativeFrame(.horizontal)
                                        //Image
                                    }//AsyncImage
                                    .zIndex(1)
                                }//if
                            }//ZStack
                            .cornerRadius(4)
                        }//ForEach
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 4, x: 0, y: 4
                        )//shadow
                    }//if
                }//HStack
            }//ScrollView
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }//VStack
    }//body
}//PodcastScrollView
