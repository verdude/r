//
//  Video.swift
//  r
//
//  Created by e on 5/12/22.
//

import SwiftUI
import AVKit

struct Video: View {
    private var player: AVPlayer?
    
    init(url: URL?) {
        if url != nil {
            self.player = AVPlayer(url: url!)
        } else {
            self.player = nil
        }
    }
    
    var body: some View {
        if player != nil {
            VideoPlayer(player: player)
        } else {
            Text("No Url Provided.")
        }
    }
}
