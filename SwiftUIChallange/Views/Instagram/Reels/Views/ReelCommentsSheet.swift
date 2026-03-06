//
//  ReelCommentsSheet.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 6.03.2026.
//

import SwiftUI

struct ReelCommentsSheet: View {
    
    var profile: Profile
    var comments: [Comment]
    @State private var message: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if comments.isEmpty {
                    
                    Text("No comments yet")
                        .font(.headline)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(comments, id: \.id) { comment in
                                ListRowView(comment)
                            }
                        }
                    }
                    
                    InputMessageView(profile)
                }
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func ListRowView(_ comment: Comment) -> some View {
        VStack {
            HStack {
                AsyncImage(url: comment.owner.profileImage)
                    .scaledToFill()
                    .frame(width: 50.resp, height: 50.resp)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom), lineWidth: 2.resp)
                            .foregroundStyle(Color.clear)
                    }
                
                VStack(spacing: 5.resp) {
                    Text(comment.owner.displayName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15.resp, weight: .bold))
                        .foregroundStyle(Color.white)
                    Text(comment.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17.resp, weight: .medium))
                        .foregroundStyle(Color.white)
                    
                    HStack {
                        Button("Replay") {
                            
                        }
                        .foregroundStyle(Color(.secondaryLabel))
                        .font(.system(size: 14.resp, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top, 5.resp)
                }
                
                Spacer()
                
                let isLiked = comment.isLiked
                Button { } label: {
                    VStack {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10.resp)
                            .frame(width: 50.resp, height: 50.resp)
                            .foregroundStyle(isLiked ? Color(.systemPink) : .white)
                            .fontWeight(isLiked ? .bold : .regular)
                        Text("\(comment.likeCount)")
                            .foregroundStyle(Color(.white))
                            .font(Font.caption.bold())
                            .padding(.top, -5.resp)
                    }
                    
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func InputMessageView(_ profile: Profile) -> some View {
        HStack(spacing: 15.resp) {
            AsyncImage(url: profile.profileImage)
                .scaledToFill()
                .frame(width: 35.resp, height: 35.resp)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom), lineWidth: 2.resp)
                        .foregroundStyle(Color.clear)
                }
            
            TextField(text: $message, label: {
                HStack {
                    Text("Join the converstaion...")
                        .foregroundStyle(Color.secondary)
                    Spacer()
                    Button {} label: {
                        Image(systemName: "arcade.stick.console")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 30.resp, height: 30.resp)
                            .foregroundStyle(Color.white)
                    }
                }
            })
            .padding(10.resp)
            .foregroundStyle(Color.secondary)
            .textInputAutocapitalization(.never)
            .clipShape(.capsule)
            .overlay(
                Capsule()
                    .stroke(Color.secondary, lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReelCommentsSheet(
        profile: Profile(
            username: "coder_acjhp",
            displayName: "Coder ACJHP",
            email: "hexa.octabin@gmail.com",
            profileImage: URL(string: "https://picsum.photos/id/\(Int.random(in: 1...100))/200/200"),
            isFollowing: false
        ),
        comments: [
            Comment(
                owner: Profile(
                    username: "coder_acjhp",
                    displayName: "prajwal_20",
                    email: "hexa.octabin@gmail.com",
                    profileImage: URL(string: "https://picsum.photos/id/6/200/200")
                ),
                text: "Brand name and whats the price?",
                createdAt: Date(),
                likeCount: Int.random(in: 0...1000)
            )
        ]
    )
}
