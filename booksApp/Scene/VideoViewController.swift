//
//  VideoViewController.swift
//  booksApp
//
//  Created by Burak Kara on 21.07.2023.
//

import AVFoundation
import AVKit
import UIKit

class VideoViewController: UIViewController {

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVideoPlayer()
    }
    private func setupVideoPlayer() {
        if let path = Bundle.main.path(forResource: "launch", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: path)
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = view.bounds
            playerLayer?.videoGravity = .resizeAspect
            view.layer.addSublayer(playerLayer!)

            NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinish), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
            
            player?.play()
        }
    }
    @objc private func videoDidFinish() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        performSegue(withIdentifier: "toUser", sender: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
}
