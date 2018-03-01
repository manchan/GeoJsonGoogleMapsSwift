//
//  ViewController.swift
//  GeoJsonGMaps
//
//  Created by matz on 2018/02/24.
//  Copyright © 2018年 matz. All rights reserved.
//

import UIKit
import GoogleMaps
import SVGKit

class ViewController: UIViewController {

    var googleMap : GMSMapView!
    let latitude: CLLocationDegrees = 35.003591
    let longitude: CLLocationDegrees = 135.750820
    
    let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    fileprivate lazy var jsonfilePath: URL = {
        let filePath = URL(fileURLWithPath: documentDir + "/Kyoto.geojson")
        return filePath
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let zoom: Float = 14
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        
        googleMap = GMSMapView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        googleMap.camera = camera
        
        let marker: GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.map = googleMap
        
        view.addSubview(googleMap)
        
        let geoJsonParser = GMUGeoJSONParser(url: jsonfilePath)
        geoJsonParser.parse()
        guard let features = geoJsonParser.features as? [GMUFeature] else { return }
        let styles = geoJsonParser.features.flatMap { $0.style }
        let renderer = GMUGeometryRenderer(map: googleMap, geometries: geoJsonParser.features, styles: styles)
        renderer.render()
        
        for f in features {
            guard let sw = f.southWest,
            let ne = f.northEast,
            let bearing = f.bearing,
            let svgUrl = f.svg
                else { continue }
            guard let swLat = sw[0] as? Double,
            let swLng = sw[1] as? Double,
            let neLat = ne[0] as? Double,
            let neLng = ne[1] as? Double
            else { continue }
            
            let southWest = CLLocationCoordinate2D(latitude: swLat, longitude: swLng)
            let northEast = CLLocationCoordinate2D(latitude: neLat, longitude: neLng)
            
            let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
//            let svgImage = SVGKImage(named: "icon.svg")
            let svgImage = SVGKImage(contentsOf: URL(string: svgUrl)!)
            let icon = svgImage?.uiImage
            let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
            print(bearing.doubleValue)
            overlay.bearing = bearing.doubleValue
            overlay.map = googleMap
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

