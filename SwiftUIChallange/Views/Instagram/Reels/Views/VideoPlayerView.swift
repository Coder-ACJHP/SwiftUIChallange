//
//  VideoPlayerView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 5.03.2026.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    let reel: Reel?
    @State private var player: AVPlayer?
    @State private var thumbnailImage: UIImage?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.black))
                .ignoresSafeArea(edges: .all)
            
            VStack {
                if let player = player {
                    VideoPlayer(player: player)
                    
                } else if let image = thumbnailImage {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                } else {
                    VStack {
                        Image(systemName: "play.slash")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color(.white))
                        
                        Text("No video available")
                            .font(Font.title3.bold())
                            .foregroundStyle(Color(.white))
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            setupPlayer(url: reel?.videoURL)
        }
        .onDisappear {
            if let player {
                player.pause()
                self.player = nil
            }
        }
        .task {
            await loadImage(with: reel?.thumbnailImage)
        }
    }
    
    private func setupPlayer(url: URL?) {
        if let url {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.volume = AVAudioSession.sharedInstance().outputVolume
            player?.play()
        }
    }
    
    private func loadImage(with url: URL?) async {
        guard let url else {
            thumbnailImage = UIImage(resource: .IMG_0590)
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                thumbnailImage = UIImage(resource: .IMG_0590)
                return
            }
            thumbnailImage = image
        } catch {
            thumbnailImage = UIImage(resource: .IMG_0590)
        }
    }
}

#Preview {
    let viewModel = InstaReelsViewModel()
    VideoPlayerView(reel: viewModel.currentReel)
}
