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
    var info: String
    var location: String
    var orgName: String
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
    }
    
    // MARK: Initialization
    init?(name: String, photo:UIImage?, info: String, location: String, orgName: String) {
        self.name = name
        self.photo = photo
        self.info = info
        self.location = location
        self.orgName = orgName
        super.init()
        
        if name.isEmpty || info.isEmpty || location.isEmpty || orgName.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
    }
    
    // question mark means it could fail
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        // must call designated initializer
        self.init(name: name, photo: photo, info: "Default info", location: "Default location", orgName: "Default orgName")
    }
}