//
//  SongListViewController.swift
//  Pocket Records
//
//  Created by Kya Suzuki on 6/28/17.
//  Copyright © 2017 Kya Suzuki. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // my tableView
    @IBOutlet weak var songList: UITableView!
    
    // hardcoded two song titles into the rows
    var data:[String] = []
    var hardCodedSongs:[String] = ["Time For Us", "Little Hollywood", "Love$ick"]
    
    // saving the song titles in my data array here
    var file:String!
    
    // number of songs that are in the songList
    var count:Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MY RECORDS" //title for songListView
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSong))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem

        let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        
        file = docsDir[0].appending("songs.txt") //for each row added, we add to the file of saved songs
        
        load()
    }
    
    // one of the required methods for implementing a tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // one of the required methods for implementing a tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // implementing the addButton
    func addSong(){
        let name = hardCodedSongs[count]
        data.insert(name, at: 0)
        let songIndex:IndexPath = IndexPath(row:0, section: 0)
        songList.insertRows(at: [songIndex], with: .automatic)
        count = count + 1
        save()
    }
    
    // implementing the editButton
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        songList.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        songList.deleteRows(at: [indexPath], with: .fade)
        count = count - 1
        save()
    }
    
    // saving the data so that when you go out of the application, the data is not erased
    func save(){

        let newSong:NSArray = NSArray(array: data)
        newSong.write(toFile:file, atomically: true)
    }
    
    // load the data that was saved in the file when opening back up the app in viewDidLoad method
    func load(){
        if let loadedData = NSArray(contentsOfFile:file) as? [String]{
        data = loadedData
        songList.reloadData()
        }
    }
    
    // this tells the songlistview controller to segue to the songplayviewcontroller when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "songPlay", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let songPlayView:SongPlayViewController = segue.destination as! SongPlayViewController
        songPlayView.navigationItem.title =  data[songList.indexPathForSelectedRow!.row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
