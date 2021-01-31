//
//  ViewController.swift
//  ToDoApp
//
//  Created by Anna on 9/10/15.
//  Copyright © 2015 Yowlu. All rights reserved.
//

import UIKit

import GoogleMobileAds

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    // main array of tasks
    var todayTasks = [Task]()
    
    // auxiliar view and path used to implement the sort process
    var auxView: UIView!
    var auxPath: IndexPath!
    
    // variable to control wether the table view cell should be with alpha 1 or 0
    var tableViewCellHideControl:Bool = true
    
    // view used to show there are no tasks yet
    @IBOutlet weak var noTaskView: UIView!
    
    // main table view
    @IBOutlet weak var tableView: UITableView!
    
    // textfield used to write new tasks
    @IBOutlet weak var newTaskTextField: UITextField!
    
    // height constraint used to show and hide the textfield
    @IBOutlet weak var addViewHeightConstraint: NSLayoutConstraint!
    
    // Google AdMob banner view
    @IBOutlet var bannerView: GADBannerView!
    
    // Google AdMob banner view height constraint
    @IBOutlet var googleAdMobHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var botonTip: UIButton!
    
    
    @IBOutlet weak var botonOL1: UIImageView!
    
    @IBOutlet weak var botonDere: UIButton!
    
    // VARIABLES
    // *******************
    // *******************
    
       var c = [String]()
    

    
    
    // **
    // **
    
    //
     // ********************************
    // INICIO
    // ********************************
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        
        
        // check if there are saved tasks in NSUserDefaults
        let savedTasks = UserDefaults.standard.object(forKey: "todayTasks") as? Data
        if savedTasks != nil {
            todayTasks = (NSKeyedUnarchiver.unarchiveObject(with: savedTasks!) as? [Task])!
            tableView.reloadData()
        }
        
        // add the delegate for the textfield
        newTaskTextField.delegate = self
        
        // add a tap gesture to the table view in order to dismiss the keyboard
        let tableViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
        tableViewTapGesture.cancelsTouchesInView = true
        tableViewTapGesture.numberOfTapsRequired = 1
        tableView.addGestureRecognizer(tableViewTapGesture)
        
        // add a tap gesture to the "no tasks view" in order to dismiss the keyboard
        let noTaskViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
        noTaskViewTapGesture.cancelsTouchesInView = true
        noTaskViewTapGesture.numberOfTapsRequired = 1
        noTaskView.addGestureRecognizer(noTaskViewTapGesture)
        
        // add a long tap gesture to the table view in order to start the sort action
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(ViewController.longPressed(_:)))
        longPressRecognizer.minimumPressDuration = 0.3;
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        // add a double tap gesture to the table view in order to check or uncheck a task
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action:#selector(ViewController.doubleTapped(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        self.tableView.addGestureRecognizer(doubleTapRecognizer)
        
        // set the default table view cell height
        self.tableView.rowHeight = 40.0
        
        

        }
        //** END INICIO
        
        
        
        
        
        
        

        
        // ************************* FUNCIONES
    
    
    
    
    
    
    
    @IBAction func FbotonTip(_ sender: Any) {
        c.append("ToDoBestt free !:  add things with PLUS sign!")
        c.append("You can add your things to do with the + sign and hitting enter")
        c.append("Always get your to do things saved on your iphone, quick and free")
        c.append("Free, Easy and powerful tool to get your things saved")
        c.append("Thanks for usign TODOBESTT: my free app to save quick notes / things to do")
        c.append("a powerful and free tool, save your quick notes")
        c.append("delete your things just slide left on the line and click Delete")
        c.append("a fast and reliable 'to do' tool, for iOS")
        let number = Int.random(in: 0...7)
        popup(titulo: c[number])
    }
    
    
    
    @IBAction func FbotonDere(_ sender: UIButton) {
        var c1: String  = "a free and powerful tool to save your todo things on your iphone- , ==visit @ol1software==(tw & ig), <<xCode 11 and swift>>* Thanks for using *"
        
        popup(titulo: c1)
        
    }
    
    
        
        //**** FUNCION PARA CREAR POPUP
        func popup(titulo: String)
        {
            // create the actual alert controller view that will be the pop-up
            let alertController = UIAlertController(title: "ToDoBestt", message: titulo, preferredStyle: .alert)

            // add the buttons/actions to the view controller
            //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Got it", style: .default) { _ in

            }
            
           // alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            
            
            DispatchQueue.main.async{
                
                if self.presentedViewController==nil{
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    self.presentedViewController!.present(alertController, animated: true, completion: nil)
                }
                
            }

            
        }
        //**** END POPUP
        
        
        
        // FUNCION Muestrapantalla = muestra/show una pantalla (viewcontroller)
        //**
        func MuestraPantalla(pantalla: String)
        {
            let secondView = self.storyboard?.instantiateViewController(withIdentifier: pantalla) as! UIViewController
            self.present(secondView, animated: true, completion: nil)
        }
        // END
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Google AdMob init
    func googleAdMobInit() {
        bannerView.load(GADRequest())
        
        // Replace this ad unit ID with your own ad unit ID.
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
    
        let request:GADRequest = GADRequest();
    
        // Requests test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADBannerView automatically returns test ads when running on a
        // simulator.
        request.testDevices = [
                                "2077ef9a63d2b398840261c8221a0c9a",  // Eric's iPod Touch
                                kGADSimulatorID // iphone simulator
                              ]
        
        bannerView.load(request);
    }
    
    // Delete Google AdMob
    func deleteGoogleAdMob() {
        googleAdMobHeightConstraint.constant = 0;
    }
    
    @IBAction func addTask(_ sender: AnyObject) {
        animateAddView(60)
        newTaskTextField.becomeFirstResponder()
    }
    
    @IBAction func newTask(_ sender: AnyObject) {
        if newTaskTextField.text! != "" {
            // create a new task
            let task = Task()
            task.taskText = newTaskTextField.text!
            task.taskCompleted = false
            
            // insert the new task on the first position of the array
            todayTasks.insert(task, at: 0)
            
            // hide the keyboard and animate the views
            hideKeyboard()
            animateAddView(0)
            
            // reload the table view by animating only the new row
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        } else {
            // in case of pressing the return button without a text, hide the keyboard and animate the views
            if(sender as! NSObject == newTaskTextField) {
                hideKeyboard()
                animateAddView(0)
            }
        }
    }
    
    func showNoTaskView() {
        UIView.animate(withDuration: 0.5, animations: {
             self.noTaskView.alpha = 1.0
        }) 
        tableView.alpha = 0.0
    }
    
    func hideNoTaskView() {
        noTaskView.alpha = 0.0
        tableView.alpha = 1.0
    }
    
    func animateAddView(_ const: CGFloat) {
        self.addViewHeightConstraint.constant = const
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) 
    }
    
    @objc func doubleTapped(_ gesture: UILongPressGestureRecognizer) {
        // get which cell has been pressed
        let locationInView = gesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: locationInView)
        
        if indexPath != nil {
            // toggle taskCompleted value
            todayTasks[((indexPath as NSIndexPath?)?.row)!].taskCompleted = !todayTasks[((indexPath as NSIndexPath?)?.row)!].taskCompleted
            
            // reload the table
            tableView.reloadData()
        }
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        // get which cell has been pressed
        let locationInView = gesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: locationInView)
        
        switch gesture.state {
            case UIGestureRecognizerState.began:
                // Beginning of the gesture
                // check if we pressed a valid cell
                if indexPath != nil {
                    // store the current indexPath
                    auxPath = indexPath
                    
                    // create a new table view cell to create a snapshot of it
                    let cell = self.tableView.cellForRow(at: indexPath!) as UITableViewCell!
                    auxView  = createAuxView(cell!)
                    
                    // set the parameters needed for correct display of the snapshot
                    auxView!.center = (cell?.center)!
                    auxView!.alpha = 0.0
                    
                    // add the snapshot to the table view
                    self.tableView.addSubview(auxView!)
                    
                    // start the control hide variable
                    tableViewCellHideControl = false
                    
                    // animate the snapshot and the cell
                    UIView.animate(withDuration: 0.25, animations: { () -> Void in
                        // set the new values of the parameters that are being animated
                        self.auxView!.center.y = locationInView.y
                        self.auxView!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                        self.auxView!.alpha = 0.98
                    
                        cell?.alpha = 0.0
                    
                        }, completion: { (finished) -> Void in
                            if finished {
                                // hide the cell only if the gesture has not ended
                                if !self.tableViewCellHideControl {
                                    cell?.isHidden = true
                                }
                            }
                        })
                    }
            break
            
        case UIGestureRecognizerState.changed:
            // Gesture state related to the movement of the snapshot
            // Get the updated parameters
            auxView!.center.y = locationInView.y
            
            // check the value of index path to prevent it is not nil and it is not the same index as the original one
            if (indexPath != nil) && (indexPath != auxPath) {
                // do the swap of the cells in the array to obtain the new order of cells
                swap(&todayTasks[(indexPath! as NSIndexPath).row], &todayTasks[(auxPath! as NSIndexPath).row])
                
                // update the table view to see the new order of cells
                tableView.moveRow(at: auxPath!, to: indexPath!)
                
                // update the index path
                auxPath = indexPath
            }
            break
            
        default:
            // Gesture state related to the end, fail or cancel of the movement
            // update the control hide variable
            tableViewCellHideControl = true
            
            // get the cell of the current path
            let cell = tableView.cellForRow(at: auxPath!) as UITableViewCell!
            
            // update the parameters to be animated
            cell?.isHidden = false
            cell?.alpha = 0.0
            
            // animate the views again
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                // set the new values of the parameters that are being animated
                self.auxView!.center = (cell?.center)!
                self.auxView!.transform = CGAffineTransform.identity
                self.auxView!.alpha = 0.0
                
                cell?.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        // remove the snapshot and set to nil the auxiliar path
                        self.auxPath = nil
                        self.auxView!.removeFromSuperview()
                        self.auxView = nil
                        
                        // ensure the cell is not hidden
                        cell?.isHidden = false
                    }
            })
            
            // reload the table to see the results
            tableView.reloadData()
            break
        }
    }
    
    func createAuxView(_ inputView: UIView) -> UIView {
        // create a snapshot of the given view (in our case a table view cell)
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        // add the snapshot to a new view
        let cell : UIView = UIImageView(image: image)
        cell.layer.masksToBounds = false
        
        // return the view
        return cell
    }

    @objc func hideKeyboard() {
        // set the textfield to empty
        newTaskTextField.text = ""
        
        // dismiss the keyboard
        self.view.endEditing(true)
        animateAddView(0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss the keyboard
        textField.resignFirstResponder()
        
        // add a new task
        newTask(textField)
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // store the array to NSUserDefaults
        // it is done here because anytime we want to reload the table we always got through this function
        let savedTaks = NSKeyedArchiver.archivedData(withRootObject: todayTasks)
        UserDefaults.standard.set(savedTaks, forKey: "todayTasks")
        
        // check if we have to show the "no tasks view"
        if todayTasks.isEmpty {
            showNoTaskView()
        } else {
            hideNoTaskView()
        }
        
        // return numberOfRowsInSection
        return todayTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell using the identifier set on Interface Builder
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell")!
        
        // set the text
        (cell.contentView.viewWithTag(1) as! UILabel).text = todayTasks[(indexPath as NSIndexPath).row].taskText
        
        // set wether the task is completed or not
        if todayTasks[(indexPath as NSIndexPath).row].taskCompleted {
            (cell.contentView.viewWithTag(2) as UIView!).alpha = 1
        } else {
            (cell.contentView.viewWithTag(2) as UIView!).alpha = 0
        }
        
        // return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // set the table view header title
        return "I HAVE TO..."
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView,forSection section: Int) {
        // change the table view header design
        // set the tint colot
        view.tintColor = UIColor.white
        
        // cast it as header in order to access the textLabel property
        let header = view as! UITableViewHeaderFooterView
        
        // change the label color and font
        header.textLabel!.textColor = UIColor.init(red: 72.0/255.0, green: 207.0/255.0, blue: 173.0/255.0, alpha: 1)
        header.textLabel!.font = UIFont(name:header.textLabel!.font.fontName, size: 18.0)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // give the desired frame to the table view footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100))
        return footer
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // check if we are deleting a cell
        if editingStyle == UITableViewCellEditingStyle.delete {
            // remove the task at the current index
            todayTasks.remove(at: (indexPath as NSIndexPath).row)
            
            // reload the table view to see the changes
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // get the delete button
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
                self.tableView.dataSource?.tableView?(
                self.tableView,
                commit: .delete,
                forRowAt: indexPath
            )
            return
        })
        
        // change its background color
        deleteButton.backgroundColor = UIColor(red: 252.0/255.0, green: 110.0/255.0, blue: 81.0/255.0, alpha: 1)
        
        // return the edited button
        return [deleteButton]
    }
}
