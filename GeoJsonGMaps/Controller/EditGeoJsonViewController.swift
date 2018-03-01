//
//  EditGeoJsonViewController.swift
//  GeoJsonGMaps
//
//  Created by matz on 2018/02/26.
//  Copyright © 2018年 matz. All rights reserved.
//

import UIKit

class EditGeoJsonViewController: UIViewController {
    
    @IBOutlet weak var jsonTextView: UITextView!
    
    let path = Bundle.main.path(forResource: "Kyoto", ofType: "geojson")
    let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    fileprivate lazy var filePath: URL = {
        let filePath = URL(fileURLWithPath: documentDir + "/Kyoto.geojson")
        return filePath
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom GeoJson to Gmaps"
        do {
            let data = try Data(contentsOf: filePath)
            // not empty json
            if let geojsonStr = String(data: data, encoding: .utf8) {
                try! geojsonStr.write(to: filePath, atomically: true, encoding: .utf8)
                readJson()
                return
            }
        } catch {
            let url = URL(fileURLWithPath: path!)
            let newData = try! Data(contentsOf: url)
            let str = String(data: newData, encoding: .utf8) ?? ""
            try! str.write(to: filePath, atomically: true, encoding: .utf8)
            readJson()
        }
    }
    
    func readJson() {
        let data = try! Data(contentsOf: filePath)
        let geojsonStr = String(data: data, encoding: .utf8)
        jsonTextView.text = geojsonStr ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readJson()
    }
    
    @IBAction func tappedRenderButton(_ sender: UIButton) {
        try! jsonTextView.text.write(to: filePath, atomically: true, encoding: .utf8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
