//
//  ModelView.swift
//  Sorting
//
//  Created by GaGan on 25/7/21.
//

import Foundation


struct APICall {
    
    
    func getData() {
        APIService().getMoviesData{ (festivals) in
            var dict: Dictionary  = [String:String]()
            var array: Array = [String]()
            var ar: [Dictionary<String, String>] = []
            
            for festival in festivals{
                for band in festival.bands!{
                    
                    dict.updateValue(band.recordLabel ?? "", forKey: "RecordLabel")
                    dict.updateValue(band.name ?? "", forKey: "BandName")
                    dict.updateValue(festival.name ?? "", forKey: "FestivalName")
                    
                    ar.append(dict)
                    array.append(band.recordLabel ?? "")
                    array = array.sorted(by: <)
                    
                }
            }
            
            array = self.unique(source: array)
            var resultArray = [Any]()
            for a in array {
                let result:[Any] = self.findBandForValueInDicArr(searchableValue: a , array: ar)!
                
                for dictionary in result
                {
                    resultArray.append(dictionary)
                }
            }
            
            dump(resultArray)
            
        }
    }
    
    
    func findBandForValueInDicArr(searchableValue: String, array: [Dictionary<String, String>]) -> [Any]?
    {
        var fileteredArray: [Any] = []
        var dict = [Any]()
        var bands: Array = [Any]()
        
        for arr in array
        {
            for (_, value) in arr {
                if (value.contains(searchableValue))
                {
                    fileteredArray.removeAll()
                    dict.removeAll()
                    dict.append(value)
                    
                    let festivalsForBand = findFestivalForValueInDicArr(searchableValue: arr["BandName"] ?? "", array: array) ?? nil//
                    let festival = FestivalforBand(name: festivalsForBand!)
                    
                    let bandForRecordLabel = BandForRecordLabel.init(name: arr["BandName"] ?? "Not Found", festival: festival)
                    
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
                    fileteredArray.sort() //Sorting alphabetically
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


