// Created by alex_corre on 7/17/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import UIKit
import AVKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func playVideo(_ sender: Any) {
    showVideoPlayerViewController(useComposition: false)
  }

  @IBAction func playCompositionVideo(_ sender: Any) {
    showVideoPlayerViewController(useComposition: true)
  }

  private func showVideoPlayerViewController(useComposition: Bool) {
    let playerController = AVPlayerViewController()

    // chose a high bitrate video for illustration
    let videoUrlString = "https://a0.muscache.com/v/a8/22/a822ce79-9cd8-53fc-842d-6264755e1e9e/a822ce799cd853fc842d6264755e1e9e.mp4"
    let videoURL = URL(string: videoUrlString)!
    let videoAsset = AVURLAsset(url: videoURL)

    // create the player item, optionally wrapping it in a composition
    var playerItem = AVPlayerItem(asset: videoAsset)

    if useComposition {
      let composition = AVMutableComposition()
      try? composition.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: videoAsset, at: CMTime.zero)
      playerItem = AVPlayerItem(asset: composition)
    }

    // instantiate a player and set it on the playerController
    let player = AVPlayer(playerItem: playerItem)
    playerController.player = player

    // show the player controller modally
    present(playerController, animated: true) {
      player.play()
    }
  }
}

