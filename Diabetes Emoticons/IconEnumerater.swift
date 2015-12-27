//
//  IconEnumerater.swift
//  Diabeticons
//
//  Created by Spruce Bondera on 3/25/15.
//  Copyright (c) 2015 michiganhackers. All rights reserved.
//

import Foundation

class IconEnumerator {    
    func icons() -> [String] {
        var icons = [String]()
        
        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let items = try! fm.contentsOfDirectoryAtPath(path)
        
        for item in items {
            if item.hasSuffix(".png") && !item.hasPrefix("AppIcon") {
                let fileName = item.substringToIndex(item.rangeOfString(".")!.startIndex)
                icons.append(fileName)
            }
        }
        return icons
    }
}