//
//  EventTableViewController.swift
//  ClubHub
//
//  Created by Kenny Law on 10/3/15.
//  Copyright © 2015 Kenny Law. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    // MARK: Properties
    
    var events = [OrgEvent]()
    
    func loadSampleEvents() {
        let photo1 = UIImage(named: "event1")!
        let event1 = OrgEvent(name: "Bondfire", photo: photo1, info: "Come meet new people at our bon(d)fire", location: "Peterson Loop", orgName: "CASA")!
        
        let photo2 = UIImage(named: "event2")!
        let event2 = OrgEvent(name: "Karaoke", photo: photo2, info: "Sing your heart out", location: "Karaoke 101", orgName: "TASA")!
        
        let photo3 = UIImage(named: "event3")!
        let event3 = OrgEvent(name: "Bowling", photo: photo3, info: "Spare me your heart", location: "Kearny Mesa Bowl", orgName: "CSES")!
        
        events += [event1, event2, event3]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        navigationItem.leftBarButtonItem = self.editButtonItem()
        
        if let savedEvents = loadEvents() {
            events += savedEvents
        } else {
            // load sample data
            loadSampleEvents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventTableViewCell", forIndexPath: indexPath) as! EventTableViewCell

        let event = events[indexPath.row]
        cell.nameLabel.text = event.name
        cell.photoImageView.image = event.photo
        cell.locationLabel.text = event.location

        return cell
    }
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as?
        EventViewController, event = sourceViewController.event {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                events[selectedIndexPath.row] = event
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal
                let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
                events.append(event)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the events
            saveEvents()
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            events.removeAtIndex(indexPath.row)
            saveEvents()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let eventDetailViewController = segue.destinationViewController as! EventViewController
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                eventDetailViewController.event = selectedEvent
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
    }
    
    // MARK: NSCoding
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: OrgEvent.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save event...")
        }
    }
    
    func loadEvents() -> [OrgEvent]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(OrgEvent.ArchiveURL.path!) as? [OrgEvent]
    }

}