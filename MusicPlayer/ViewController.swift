//
//  ViewController.swift
//  MusicPlayer
//
//  Created by DDUKK7 on 31/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var table:UITableView!
    var songs = [Song]()
    override func viewDidLoad() {
        configureSongs()
        table.delegate = self
        table.dataSource = self
        super.viewDidLoad()
    }
    
    func configureSongs(){
        songs.append(Song(name: "Gangsta's Paradise",
                          albumName: " Gangsta's Paradise",
                          artistName: " Coolio, Kylian Mash",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "What a Wonderful World",
                          albumName: "What a Wonderful World",
                          artistName: "Louis Armstrong",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Hey there Delilah",
                          albumName: "All That We Needed",
                          artistName: "Plain White T's",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Gangsta's Paradise",
                          albumName: " Gangsta's Paradise",
                          artistName: " Coolio, Kylian Mash",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "What a Wonderful World",
                          albumName: "What a Wonderful World",
                          artistName: "Louis Armstrong",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Hey there Delilah",
                          albumName: "All That We Needed",
                          artistName: "Plain White T's",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Gangsta's Paradise",
                          albumName: " Gangsta's Paradise",
                          artistName: " Coolio, Kylian Mash",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "What a Wonderful World",
                          albumName: "What a Wonderful World",
                          artistName: "Louis Armstrong",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Hey there Delilah",
                          albumName: "All That We Needed",
                          artistName: "Plain White T's",
                          imageName: "cover3",
                          trackName: "song3"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else{
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
        
    }
    
}
struct Song{
    let name:String
    let albumName:String
    let artistName:String
    let imageName:String
    let trackName:String
    
}




