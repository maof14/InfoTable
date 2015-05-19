//
//  DetailsViewController.swift
//  InfoTable
//
//  Created by Mattias Olsson on 2015-05-16.
//  Copyright (c) 2015 MOAN Enterprises. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var id = 0
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    
    let db = MyViewState.db
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sql_stmt = "SELECT * FROM guitars WHERE id = ?"
        
        var args: [Int] = []
        args.append(self.id)
        
        var result = db.executeQueryAndReturnRow(sql_stmt, params: args)
        
        var imageName: String = result.objectAtIndex(0)["image"] as! String
        var model: String = result.objectAtIndex(0)["model"] as! String
        var description: String = result.objectAtIndex(0)["description"] as! String
        var brand: String! = result.objectAtIndex(0)["brand"] as! String
        
        let image = UIImage(named: imageName)
        self.title = model
        self.imageView.image = image
        self.textView.editable = false
        self.textView.text = description
        
        self.scrollView.scrollEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
