//
//  ViewController.swift
//  CDCalendar
//
//  Created by Victor Lehr on 7/26/24.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    @IBOutlet weak var eventLabel: UILabel!
    
    var savedEventId = ""
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createEvent(title:String, startDate:NSDate, endDate:NSDate) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate as Date?
        event.endDate = endDate as Date?
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
            self.eventLabel.text = "Event added to calendar"
        } catch {
            print("Error")
        }
    }

    @IBAction func addEventSelected(_ sender: Any) {
        let startDate = NSDate()
        let endDate = startDate.addingTimeInterval(60*60)
        
        if (EKEventStore.authorizationStatus(for: .event) != .authorized) {
            eventStore.requestAccess(to: .event) {
                (granted, error) in
                self.createEvent(title:"procrastinate for an hour", startDate: startDate, endDate: endDate)
            }
        } else {
            createEvent(title:"procrastinate for an hour", startDate: startDate, endDate: endDate)
        }
    }
    
    func deleteEvent(eventIdentifier: String) {
        let eventToRemove = eventStore.event(withIdentifier: eventIdentifier)
        if eventToRemove != nil {
            do {
                try eventStore.remove(eventToRemove!, span: .thisEvent)
                eventLabel.text = "Event removed from calendar"
            } catch {
                print("Error")
            }
        }
    }
    
    @IBAction func removeEventSelected(_ sender: Any) {
        if EKEventStore.authorizationStatus(for: .event) != .authorized {
            eventStore.requestAccess(to: .event) {
                (granted, error) in
                self.deleteEvent(eventIdentifier: self.savedEventId)
            }
        } else {
            deleteEvent(eventIdentifier: savedEventId)
        }
    }
    
}

