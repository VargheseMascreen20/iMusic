//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by DDUKK7 on 31/10/22.
//
import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position : Int = 0
    public var songs: [Song] = []
    @IBOutlet var holder: UIView!
    
    var player:AVAudioPlayer?
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let playPauseButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    func configure(){
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                return
            }
            player.volume = 0.5
            player.play()
        }catch{
            print("Error Occured")
            
        }
        albumImageView.frame = CGRect(x: 20, y: 10, width: holder.frame.size.width-50, height: holder.frame.size.height-400)
        songNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height+10, width: holder.frame.size.width-20, height: 70)
        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height+10+70, width: holder.frame.size.width-20, height: 70)
        albumNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height+10+140, width: holder.frame.size.width-20, height: 70)
        albumImageView.image = UIImage(named: song.imageName)
        songNameLabel.text = song.name
        artistNameLabel.text = song.artistName
        albumNameLabel.text = song.albumName
        
        
        holder.addSubview(albumImageView)
        holder.addSubview(songNameLabel)
        holder.addSubview(artistNameLabel)
        holder.addSubview(albumNameLabel)
        
        
        let slider = UISlider(frame:CGRect(x: 20,
                                           y: holder.frame.size.height - 70,
                                           width: holder.frame.size.width - 40,
                                           height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didslideslider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
        
        let nextButton = UIButton()
        let backButton = UIButton()
        
        let yPosition = albumNameLabel.frame.origin.y + 70 + 20
        let size:CGFloat = 70
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size-20, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
    }
    
    @objc func didTapPlayPauseButton(){
        if player?.isPlaying == true{
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }else{
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    @objc func didTapNextButton(){
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    @objc func didTapBackButton(){
        if position < (songs.count - 1) {
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didslideslider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    
}
