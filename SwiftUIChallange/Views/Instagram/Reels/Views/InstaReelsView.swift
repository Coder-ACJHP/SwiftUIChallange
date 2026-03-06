//
//  InstaReelsView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 5.03.2026.
//

import SwiftUI

struct InstaReelsView: View {
    
    @State private var currentReelId: UUID?
    @State private var isPresented: Bool = false
    @StateObject var viewModel = InstaReelsViewModel()
        
    var body: some View {
        ZStack {
            // Player View
            if #available(iOS 17.0, *) {
                playerView
            }
            // Control View
            controlView
        }
        .background(Color.black)
        .onAppear {
            currentReelId = viewModel.currentReel?.id
        }
        .sheet(isPresented: $isPresented) {
            if let comments = viewModel.currentReel?.comments,
               let profile = viewModel.currentReel?.owner {
                ReelCommentsSheet(
                    profile: profile,
                    comments: comments
                )
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
    
    @available(iOS 17.0, *)
    private var playerView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.reels, id: \.id) { reel in
                    VideoPlayerView(reel: reel)
                        .frame(maxWidth: .infinity)
                        .frame(height: viewModel.screenSize.height)
                        .id(reel.id)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $currentReelId)
        .ignoresSafeArea()
        .onChange(of: currentReelId) { _, newId in
            viewModel.updateCurrentReel(byId: newId)
        }
    }
    
    private var controlView: some View {
        VStack {
            // Top nav items
            navbarItems
            
            Spacer()
            
            HStack {
                profileView
                
                Spacer()
                
                toolbarView
            }
            .padding(.bottom, 10.resp)
        }
        .padding(.horizontal)
    }
    
    private var navbarItems: some View {
        HStack(spacing: 15.resp) {
            Button {} label: {
                Image(systemName: "plus")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10.resp)
                    .frame(width: 40.resp, height: 40.resp)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Button {} label: {
                Text("Reels")
                    .font(.system(size: 20.resp, weight: .bold))
                    .foregroundStyle(.white)
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15.resp, height: 15.resp)
                    .foregroundStyle(.white)
            }
            
            Button {} label: {
                Text("Friends")
                    .font(.system(size: 20.resp, weight: .bold))
                    .foregroundStyle(.white)
                HStack(spacing: -7.resp) {
                    ForEach((0..<3).reversed(), id: \.self) { index in
                        Image(systemName: "person.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(5.resp)
                            .frame(width: 20.resp, height: 20.resp)
                            .foregroundStyle(.white)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.white.opacity(0.3), lineWidth: 1)
                            }
                            .zIndex(Double(index))
                    }
                    
                }
                .padding(.leading, -3.resp)
            }
            
            Spacer()
            
            Button {} label: {
                Image(systemName: "slider.horizontal.3")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10.resp)
                    .frame(width: 40.resp, height: 40.resp)
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var profileView: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 15.resp) {
                // Tag
                Button {} label: {
                    HStack {
                        Image(systemName: "pencil")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .padding(8.resp)
                            .frame(width: 30.resp, height: 30.resp)
                            .foregroundStyle(.white)
                        
                        let tags = viewModel.currentReel?.tag ?? ""
                        Text("From \(tags)")
                            .foregroundStyle(Color(.white))
                            .font(Font.headline.bold())
                    }
                }
                .padding(.horizontal, 10.resp)
                .frame(maxHeight: 40.resp, alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(18.resp)
                
                // Profile Image & name
                HStack {
                    Image(uiImage: UIImage(resource: .IMG_0590))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50.resp, height: 50.resp)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom), lineWidth: 2.resp)
                                .foregroundStyle(Color.clear)
                        }
                    
                    let displayName = viewModel.currentReel?.owner.displayName ?? ""
                    Text(displayName)
                        .font(.system(size: 15.resp, weight: .bold))
                        .foregroundStyle(Color.white)
                    
                    Button { viewModel.currentReel?.owner.isFollowing.toggle() } label: {
                        Text(viewModel.currentReel?.owner.isFollowing ?? false ? "Following" : "Follow")
                            .font(.system(size: 15.resp, weight: .bold))
                            .foregroundStyle(Color(.white))
                    }
                    .padding(5.resp)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7.resp)
                            .stroke(Color.white, lineWidth: 1.resp)
                            .background(Color(.clear))
                    }
                }
                // Reel Caption
                let caption = viewModel.currentReel?.caption ?? ""
                Text(caption)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16.resp, weight: .medium))
                    .minimumScaleFactor(0.7)
                
            }
        }
    }
    
    private var toolbarView: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10.resp) {
                // Like button
                let isLiked = viewModel.currentReel?.isLiked ?? false
                Button { viewModel.currentReel?.isLiked.toggle() } label: {
                    VStack {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10.resp)
                            .frame(width: 50.resp, height: 50.resp)
                            .foregroundStyle(isLiked ? Color(.systemPink) : .white)
                            .fontWeight(isLiked ? .bold : .regular)
                        Text("\(viewModel.currentReel?.likeCount ?? .zero)")
                            .foregroundStyle(Color(.white))
                            .font(Font.caption.bold())
                            .padding(.top, -5.resp)
                    }
                    
                }
                // Comments button
                Button { isPresented = true } label: {
                    VStack {
                        Image(systemName: "message")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10.resp)
                            .frame(width: 50.resp, height: 50.resp)
                            .foregroundStyle(.white)
                        Text("\(viewModel.currentReel?.commentCount ?? .zero)")
                            .foregroundStyle(Color(.white))
                            .font(Font.caption.bold())
                            .padding(.top, -5.resp)
                    }
                    
                }
                // Repost button
                Button { viewModel.currentReel?.isReposted.toggle() } label: {
                    VStack {
                        let isReposted = viewModel.currentReel?.isReposted ?? false
                        Image(systemName: "repeat")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10.resp)
                            .frame(width: 50.resp, height: 50.resp)
                            .foregroundStyle(.white)
                            .fontWeight(isReposted ? .bold : .regular)
                        Text("\(viewModel.currentReel?.repostCount ?? .zero)")
                            .foregroundStyle(Color(.white))
                            .font(Font.caption.bold())
                            .padding(.top, -5.resp)
                    }
                    
                }
                Button {} label: {
                    VStack {
                        Image(systemName: "paperplane")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10.resp)
                            .frame(width: 50.resp, height: 50.resp)
                            .foregroundStyle(.white)
                        Text("\(viewModel.currentReel?.shareCount ?? .zero)")
                            .foregroundStyle(Color(.white))
                            .font(Font.caption.bold())
                            .padding(.top, -5.resp)
                    }
                    
                }
                // More menu button
                Button {} label: {
                    Image(systemName: "ellipsis")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10.resp)
                        .frame(width: 45.resp, height: 45.resp)
                        .foregroundStyle(.white)
                }
                Button {} label: {
                    Image(uiImage: UIImage(resource: .IMG_0590))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35.resp, height: 35.resp)
                        .clipShape(RoundedRectangle(cornerRadius: 8.resp))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8.resp)
                                .stroke(.white, lineWidth: 1.resp)
                                .background(Color(.clear))
                        }
                        
                }
            }
        }
    }
}

#Preview {
    InstaReelsView()
}
