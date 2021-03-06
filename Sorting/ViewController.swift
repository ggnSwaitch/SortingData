//
//  ViewController.swift
//  Sorting
//
//  Created by GaGan on 25/7/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        APICall().getData()
        
        
    }
    
    func findBandForValueInDicArr(searchableValue: String, array: [Dictionary<String, String>]) -> [Any]?
    {
        var fileteredArray: [Any] = []
        var dict = [Any]()
        var bands: Array = [Any]()
        var festivals: Array = [String]()
       
        for arr in array
        {
            for (key, value) in arr {
                if (value.contains(searchableValue))
                {
                    fileteredArray.removeAll()
                    dict.removeAll()
                    dict.append(value)
                    
                    let festivalsForBand = findFestivalForValueInDicArr(searchableValue: arr["BandName"] ?? "", array: array) ?? nil//
                    let festival = FestivalforBand(name: festivalsForBand!)
                    
                    var bandForRecordLabel = BandForRecordLabel.init(name: arr["BandName"] ?? "Not Found", festival: festival)
                   
                    var bandForRecordLabelName = bandForRecordLabel.name 
                   
                    bands.append(bandForRecordLabel)
                    
                    dict.append(bands)
                   
                    fileteredArray.append(dict)
                    
                }
            }
            
        }
        return fileteredArray
        
    }
    
    func findFestivalForValueInDicArr(searchableValue: String, array: [Dictionary<String, String>]) -> [String]?
    {
        var fileteredArray: [String] = []
        var dict = [String:Any]()
        var bands: Array = [String]()
        var festivals: Array = [String]()
        for arr in array
        {
            for (_, value) in arr {
                if (value.contains(searchableValue))
                {
                    fileteredArray.removeAll()
                    
                    bands.append(arr["BandName"] ?? "")
                    bands = bands.sorted(by: <)
                    festivals.append(arr["FestivalName"] ?? "")
                   
                    dict.updateValue(festivals, forKey: "FestivalName")
                    
                    fileteredArray.append(contentsOf: festivals)
                    fileteredArray.sort()
                }
            }
            
        }
        return fileteredArray
        
    }
    
    
    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
}


struct FestivalforBand {
    var name: [String]
}


struct BandForRecordLabel {
    var name: String
    var festival: FestivalforBand
}


struct RecordLabel {
    var name: String
    var band: BandForRecordLabel
}


