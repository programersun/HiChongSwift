//
//  AboutMeModifyLocationViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreData

class AboutMeModifyLocationViewController: UIViewController {
    
    weak var delegate: AboutMeModifyLocationDelegate?
    
    var province: String!
    var city: String!
    var town: String!
    
    var isSquare : Bool = false
    var cityNameForSquare : String?
    
    private var provinces:  [Region]?
    private var cities:       [Region]?
    private var towns:       [Region]?
    
    /**
    魔数，用于获取初始数据
    
    - topLevel:       所有省级行政区划的 parent_id
    - pekingProvince: 省级“北京”的 region_id
    - pekingCity:     市级“北京”的 region_id
    */
    private enum magicNumber: Int {
        case topLevel = 1
        case pekingProvince = 2
        case pekingCity = 52
    }
    
    @IBOutlet private weak var icyPickerView: UIPickerView!
    @IBOutlet private weak var icyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "选择位置"
        
        var provinceText: String?
        var cityText: String?
        var townText: String?
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        let fetchRequset = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
        fetchRequset.entity = entity
        let predicate = NSPredicate(format: "region_id == %@ OR region_id == %@ OR region_id == %@", argumentArray:[province, city, town])
        fetchRequset.predicate = predicate
        var error: NSError? = nil
        let result = context.executeFetchRequest(fetchRequset, error: &error)
        if let entities = result {
            for regionEntity in entities as! [Region] {
                switch regionEntity.region_id {
                case province.toInt()!:
                    provinceText = regionEntity.region_name
                case city.toInt()!:
                    cityText = regionEntity.region_name
                    cityNameForSquare = cityText
                case town.toInt()!:
                    townText = regionEntity.region_name
                default:
                    break
                }
            }
        } else {
            println("error!===>\(error)")
        }
        
        if let townText = townText {
            if(isSquare)
            {
                icyLabel.text = "\(provinceText!) \(cityText!) "
            }
            else
            {
                icyLabel.text = "\(provinceText!) \(cityText!) \(townText)"
            }
        } else {
            icyLabel.text = "\(provinceText!) \(cityText!)"
        }
        
        
        addRightButton("确定", action: "rightButtonPressed:")
        
        loadInitData()
    }
    
    private func loadInitData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let context = appDelegate.managedObjectContext {
            // 获取所有省份
            let fetchRequset = NSFetchRequest()
            let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
            fetchRequset.entity = entity
            let predicate = NSPredicate(format: "parent_id == %@", argumentArray: [magicNumber.topLevel.rawValue])
            fetchRequset.predicate = predicate
            let sortDescriptor = NSSortDescriptor(key: "region_id", ascending: true)
            fetchRequset.sortDescriptors = [sortDescriptor]
            var error: NSError? = nil
            let result = context.executeFetchRequest(fetchRequset, error: &error)
            if let entities = result {
                provinces = [Region]()
                for regionEntity in entities as! [Region] {
                    provinces?.append(regionEntity)
                }
                icyPickerView.reloadComponent(0)
            } else {
                println("error!===>\(error)")
            }
            // 获取北京的市级菜单
            let cityFetchRequset = NSFetchRequest()
            let cityEntity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
            cityFetchRequset.entity = cityEntity
            let cityPredicate = NSPredicate(format: "parent_id == %@", argumentArray: [magicNumber.pekingProvince.rawValue])
            cityFetchRequset.predicate = cityPredicate
            let citySortDescriptor = NSSortDescriptor(key: "region_id", ascending: true)
            cityFetchRequset.sortDescriptors = [citySortDescriptor]
            let cityResult = context.executeFetchRequest(cityFetchRequset, error: &error)
            if let entities = cityResult {
                cities = [Region]()
                for regionEntity in entities as! [Region] {
                    cities?.append(regionEntity)
                }
                icyPickerView.reloadComponent(1)
            } else {
                println("error!===>\(error)")
            }
            // 获取北京的县级菜单
            let townFetchRequset = NSFetchRequest()
            let townEntity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
            townFetchRequset.entity = townEntity
            let townPredicate = NSPredicate(format: "parent_id == %@", argumentArray: [magicNumber.pekingCity.rawValue])
            townFetchRequset.predicate = townPredicate
            let townSortDescriptor = NSSortDescriptor(key: "region_id", ascending: true)
            townFetchRequset.sortDescriptors = [townSortDescriptor]
            let townResult = context.executeFetchRequest(townFetchRequset, error: &error)
            if let entities = townResult {
                towns = [Region]()
                for regionEntity in entities as! [Region] {
                    towns?.append(regionEntity)
                }
                icyPickerView.reloadComponent(1)
            } else {
                println("error!===>\(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        if(isSquare)
        {
            ZXY_UserConstantFile.cityIDForSqure = city
            ZXY_UserConstantFile.cityNameForSqure = cityNameForSquare
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        let parameters = [
            "user_name" : LCYCommon.sharedInstance.userName!,
            "province"  : province,
            "city"      : city,
            "town"      : town
        ]
        showHUDWithTips("正在修改")
        LCYNetworking.sharedInstance.POST(LCYApi.UserModifyLocation, parameters: parameters,
            success: { [weak self](object) -> Void in
                self?.hideHUD()
                if let result = object["result"]?.boolValue {
                    if result {
                        self?.alertWithDelegate("修改成功", tag: 9001, delegate: self)
                        if let strongSelf = self {
                            strongSelf.delegate?.didModifyLocation(strongSelf.province, city: strongSelf.city, town: strongSelf.town)
                        }
                    } else {
                        self?.alert("修改失败")
                    }
                } else {
                    self?.alert("修改失败")
                }
                return
            }) { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("修改失败，请检查网络状态")
                return
        }
    }
    
    @IBAction func chooseButtonPressed(sender: AnyObject) {
        if provinces == nil || cities == nil || towns == nil {
            return
        }
        let provinceRegion = provinces![icyPickerView.selectedRowInComponent(0)]
        let cityRegion = cities![icyPickerView.selectedRowInComponent(1)]
        if(!isSquare)
        {
            let townRegion: Region? = towns?.count == 0 ? nil : towns![icyPickerView.selectedRowInComponent(2)]
            province = provinceRegion.region_id.stringValue
            city = cityRegion.region_id.stringValue
            if let townRegion = townRegion {
                icyLabel.text = "\(provinceRegion.region_name) \(cityRegion.region_name) \(townRegion.region_name)"
                town = townRegion.region_id.stringValue
            } else {
                icyLabel.text = "\(provinceRegion.region_name) \(cityRegion.region_name)"
                town = "0"
            }

        }
        else
        {
            province = provinceRegion.region_id.stringValue
            city = cityRegion.region_id.stringValue
            icyLabel.text = "\(provinceRegion.region_name) \(cityRegion.region_name) "
        }
        if(isSquare)
        {
            cityNameForSquare = cityRegion.region_name
        }
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

extension AboutMeModifyLocationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if(isSquare)
        {
            return 2
        }
        return 3
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            if let unwrapped = provinces {
                return unwrapped.count
            } else {
                return 0
            }
        case 1:
            if let unwrapped = cities {
                return unwrapped.count
            } else {
                return 0
            }
        case 2:
            if let unwrapped = towns {
                return unwrapped.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch component {
        case 0:
            return provinces![row].region_name
        case 1:
            return cities![row].region_name
        case 2:
            return towns![row].region_name
        default:
            return "超逸是天才!"
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if provinces == nil || cities == nil || towns == nil {
            return
        }
        switch component {
        case 0:
            // 改变省级区划
            let provinceID = provinces![row].region_id
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext!
            let fetchRequset = NSFetchRequest()
            let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
            fetchRequset.entity = entity
            let predicate = NSPredicate(format: "parent_id == %@", argumentArray:[provinceID])
            fetchRequset.predicate = predicate
            var error: NSError? = nil
            let result = context.executeFetchRequest(fetchRequset, error: &error)
            if let entities = result {
                cities = [Region]()
                for regionEntity in entities as! [Region] {
                    cities?.append(regionEntity)
                }
                icyPickerView.reloadComponent(1)
            } else {
                println("error!===>\(error)")
            }
            pickerView.selectRow(0, inComponent: 1, animated: false)
            fallthrough
        case 1:
            // 改变市级区划
            let cityID = cities![pickerView.selectedRowInComponent(1)].region_id
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext!
            let fetchRequset = NSFetchRequest()
            let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
            fetchRequset.entity = entity
            let predicate = NSPredicate(format: "parent_id == %@", argumentArray:[cityID])
            fetchRequset.predicate = predicate
            var error: NSError? = nil
            let result = context.executeFetchRequest(fetchRequset, error: &error)
            if let entities = result {
                towns = [Region]()
                for regionEntity in entities as! [Region] {
                    towns?.append(regionEntity)
                }
                if(!isSquare)
                {
                    icyPickerView.reloadComponent(2)
                }
            } else {
                println("error!===>\(error)")
            }
            if(!isSquare)
            {
                pickerView.selectRow(0, inComponent: 2, animated: false)
            }
        default:
            break
        }
    }
}

extension AboutMeModifyLocationViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 9001 {
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

protocol AboutMeModifyLocationDelegate: class {
    func didModifyLocation(province: String, city: String, town: String)
}
