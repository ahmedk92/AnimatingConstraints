//
//  ViewController.swift
//  AnimatingConstraints
//
//  Created by Arabia -IT on 5/9/19.
//  Copyright © 2019 Arabia-IT. All rights reserved.
//

import UIKit

fileprivate let TOP_VIEW_DEFAULT_HEIGHT: CGFloat = 50

class ViewController: UIViewController {
    
    private let items = Array(0..<1000)
    @IBOutlet private var topViewHeightConstraint: NSLayoutConstraint!
    private var lastContentOffsetY: CGFloat = 0
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let absDelta = abs(scrollView.contentOffset.y - lastContentOffsetY)
        
        // bouncing
        if scrollView.contentOffset.y < 0 {
            topViewHeightConstraint.constant = TOP_VIEW_DEFAULT_HEIGHT - scrollView.contentOffset.y
        } else {
            if scrollView.contentOffset.y < lastContentOffsetY {
                topViewHeightConstraint.constant = min(TOP_VIEW_DEFAULT_HEIGHT, topViewHeightConstraint.constant + absDelta)
            } else {
                topViewHeightConstraint.constant = max(0, topViewHeightConstraint.constant - absDelta)
            }
        }
        lastContentOffsetY = scrollView.contentOffset.y
    }
}

