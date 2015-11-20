//
//  Emoticon.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/19/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import Foundation
import CoreData

class Emoticon : NSManagedObject {
    @NSManaged var title: String!
    @NSManaged var image: String!
    @NSManaged var isFavorite: NSNumber!
}