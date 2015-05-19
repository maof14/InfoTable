//
//  FirstViewController.swift
//  InfoTable
//
//  Created by Mattias Olsson on 2015-05-16.
//  Copyright (c) 2015 MOAN Enterprises. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var guitars: [String] = []
    var chosenTarget: Int = 0
    
    let db = MyViewState.db
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Den här borde väl ligga i MyViewState. Som i förra appen. Det är bra. Så är den ju liksom "igång" i hela programmet och kan köras. :) 
        
        
        self.guitars = self.db.executeQueryAndReturnArrayForColumn("SELECT * FROM guitars", column: "model")
        
        // databashora slut.
        
        // Do any additional setup after loading the view.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.guitars.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel!.text = self.guitars[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.chosenTarget = indexPath.row + 1
        performSegueWithIdentifier("toDetails", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toDetails") {
            println("Running segue")
            var destinationViewController = segue.destinationViewController as! DetailsViewController
            destinationViewController.id = self.chosenTarget
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
}
