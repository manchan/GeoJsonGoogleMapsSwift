//
//  MapWebViewController.swift
//  GeoJsonGMaps
//
//  Created by matz on 2018/02/27.
//  Copyright © 2018年 matz. All rights reserved.
//

import UIKit

class MapWebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        guard let path = Bundle.main.path(forResource: "map-bearing", ofType: "html") else { return }
        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: path)))
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
