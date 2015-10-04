//
//  OrgEvent.swift
//  ClubHub
//
//  Created by Kenny Law on 10/3/15.
//  Copyright © 2015 Kenny Law. All rights reserved.
//

import UIKit

class OrgEvent : NSObject, NSCoding {
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var orgName: String
    var date: String
    var location: String
    var info: String
    var category: String
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let orgNameKey = "orgName"
        static let dateKey = "date"
        static let locationKey = "location"
        static let infoKey = "info"
        static let categoryKey = "category"
    }
    
    // MARK: Initialization
    init?(name: String, photo:UIImage?, orgName: String, date: String, location: String, info: String, category: String) {
        self.name = name
        self.photo = photo
        self.orgName = orgName
        self.date = date
        self.location = location
        self.info = info
        self.category = category
        super.init()
        
        if name.isEmpty || info.isEmpty || location.isEmpty || orgName.isEmpty || date.isEmpty || category.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(orgName, forKey: PropertyKey.orgNameKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(location, forKey: PropertyKey.locationKey)
        aCoder.encodeObject(info, forKey: PropertyKey.infoKey)
        aCoder.encodeObject(category, forKey: PropertyKey.categoryKey)
    }
    
    // question mark means it could fail
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        let orgName = aDecoder.decodeObjectForKey(PropertyKey.orgNameKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! String
        let location = aDecoder.decodeObjectForKey(PropertyKey.locationKey) as! String
        let info = aDecoder.decodeObjectForKey(PropertyKey.infoKey) as! String
        let category = aDecoder.decodeObjectForKey(PropertyKey.categoryKey) as! String
        
        // must call designated initializer
        self.init(name: name, photo: photo, orgName: orgName, date: date, location: location, info: info, category: category)
    }
}