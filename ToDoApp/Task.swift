//
//  Task.swift
//  ToDoApp
//
//  Created by Anna on 9/10/15.
//  Copyright © 2015 Yowlu. All rights reserved.
//

import Foundation

class Task:NSObject{

    var taskText : String = ""
    var taskCompleted : Bool = false
    
    override init(){
        
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        self.taskText = aDecoder.decodeObject(forKey: "taskText") as! String
        self.taskCompleted = aDecoder.decodeBool(forKey: "taskCompleted")
    }
    
    @objc func encodeWithCoder(_ aCoder: NSCoder!) {
        aCoder.encode(taskText, forKey: "taskText")
        aCoder.encode(taskCompleted, forKey: "taskCompleted")
    }
}
