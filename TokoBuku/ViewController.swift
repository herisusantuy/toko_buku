//
//  ViewController.swift
//  TokoBuku
//
//  Created by Heri Susanto on 16/02/21.
//  Copyright © 2021 Heri Susanto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var manageObjectContext: NSManagedObjectContext!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadBooks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        let book: Book = loadBooks()[indexPath.row]
        cell.textLabel?.text = book.title
        return cell
    }
    
    override func viewDidLoad() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
    }
    
    func loadBooks() -> [Book] {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        var result: [Book] = []
        do {
            result = try manageObjectContext.fetch(fetchRequest)
        } catch {
            NSLog("My Error: %@", error as NSError)
        }
        return result
    }
    

    @IBOutlet weak var myTableView: UITableView!

    @IBAction func addNew(_ sender: Any) {
        let book: Book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: manageObjectContext) as! Book
        book.title = "My book \(String(loadBooks().count))"
        do {
            try manageObjectContext.save()
        } catch let error as NSError {
            NSLog("MY Error: %@", error)
        }
        myTableView.reloadData()
    }
    
}

