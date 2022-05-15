//
//  ContentView.swift
//  r
//
//  Created by e on 4/30/22.
//

import SwiftUI

enum Page {
    case singleImage, search, gallery, video
}

struct VideoPrefKey: PreferenceKey {
    static var defaultValue: VideoPref?

    static func reduce(value: inout VideoPref?, nextValue: () -> VideoPref?) {
        value = nextValue()
    }
}

struct VideoPref: Equatable, Identifiable {
    let id: String
    
    static func == (lhs: VideoPref, rhs: VideoPref) -> Bool {
        lhs.id == rhs.id
    }
}

struct ContentView: View {
    @State private var sub: String = ""
    @State private var listings: [Listing] = []
    @State private var view: Page? = Page.search
    @State private var videoId: String?
    @State private var searchStatus: SearchStatus = .waiting
    @State private var pref: VideoPref?
    private var videoView: PrefVideoView?

    var body: some View {
        NavigationView {
            VStack {
                Search(sub: $sub, view: $view, status: $searchStatus)
                NavigationLink(destination: SubredditGallery(view: $view, sub: $sub, status: $searchStatus), tag: Page.gallery,
                               selection: $view) { }
            }
        }
    }
}

struct PrefVideoView: View {
    @Binding var view: Page?
    @Binding var videoId: String?
    var show: Bool = false
    
    var body: some View {
        Video(url: nil)
            .onPreferenceChange(VideoPrefKey.self) { pref in
                Logger.debug("PREF CHANGE")
                if pref != nil {
                    Logger.debug(pref!.id)
                    videoId = pref!.id
                    view = Page.video
                } else {
                    Logger.error("VideoPref is nil on pref change")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
