//
//  Image.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @Binding var view: Page?
    @State var showVideo: Bool = false
    private var listing_: Listing
    private var delete_: (_: String) -> Void
    private var id: String
    private var url: URL
    private var mp4Url: URL?
    
    init(view: Binding<Page?>, listing: Listing, delete: @escaping (_: String) -> Void) {
        self.id = listing.id
        self.url = URL(string: replaceHTMLEncoding(for: listing.preview!.images[0].source.url))!
        if listing.preview!.reddit_video_preview != nil {
            self.mp4Url = URL(string: listing.preview!.reddit_video_preview!.fallback_url)
        }
        self.listing_ = listing
        self.delete_ = delete
        self._view = view
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    errorView(e: phase.error)
                } else {
                    Color.gray
                }
            }
            .scaledToFit()
        }.onTapGesture {
            if mp4Url != nil {
                view = Page.video
            }
        }
        if mp4Url != nil {
            HStack {
                Text(mp4Url!.absoluteString)
                NavigationLink(destination: Video(url: mp4Url), isActive: $showVideo) { }
            }
        } else {
            Text("No url!")
        }
    }
    
    @ViewBuilder private func errorView(e: Error?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image.resizable().onAppear {
                    Logger.error("Failed first Load of image: \(listing_.id). First error")
                }
            default:
                EmptyView().onAppear {
                    delete_(self.id)
                    Logger.error("Failed image load on retry")
                }
            }
        }
    }
}