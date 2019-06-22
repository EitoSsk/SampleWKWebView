//
//  ViewController.swift
//  SampleWKWebView
//
//  Created by beams001 on 2019/06/22.
//  Copyright © 2019 bms. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webViewContainer: UIView!
    private let url = "http://xxx.xxx.x.x"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params: [String: Any] = [
            "hoge": "hoge",
            "huga": "huga"
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            let task = session.dataTask(with: request as URLRequest)
            task.resume()
        }catch{
            print(error.localizedDescription)
        }
    }
}
// MARK: URLSessionDataDelegate -
extension ViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        DispatchQueue.main.async(execute: {
            let webView = WKWebView(frame: self.webViewContainer.bounds)
            self.webViewContainer.addSubview(webView)
            webView.load(data, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: URL(string: self.url)!)
        })
    }
}
