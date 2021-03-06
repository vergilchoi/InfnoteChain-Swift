//
//  BlockDetailViewController.swift
//  InfnoteChain_Example
//
//  Created by Vergil Choi on 2018/9/30.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import UIKit
import InfnoteChain

class BlockDetailViewController: UITableViewController {
    
    let keyNames = ["validation", "chain_id", "height", "time", "prev_hash", "hash", "signature", "payload"]
    let titles = ["Validation", "Chain ID", "Height", "Time", "Prev Hash", "Hash", "Signature", "Payload"]
    var block: Block!
    var info: [String: Any]!
    var isConfirmable = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        info = block.dict
        
        if isConfirmable {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTouched(_:)))
        }
    }
    
    @objc func doneButtonTouched(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func exportButtonTouched(_ sender: Any) {
        let content = try! JSONSerialization.data(withJSONObject: block.dict, options: [])
        UIPasteboard.general.string = String(data: content, encoding: .utf8)
        let alert = UIAlertController(title: "Block #\(block.height) JSON copied in Pastboard", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommonInfoCell
        if indexPath.section == 0 {
            cell.prepareViews(content: block.validate() ? "Valid" : "Invalid")
            cell.textView.textColor = block.validate() ? .green : .red
        }
        else if indexPath.section == 1 {
            cell.prepareViews(content: block.chainID)
        }
        else if indexPath.section == 2 {
            cell.prepareViews(content: "\(block.height)")
        }
        else if indexPath.section == 3 {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            cell.prepareViews(content: formatter.string(from: Date(timeIntervalSince1970: TimeInterval(block.time))))
        }
        else if indexPath.section == 7 {
            if let json = try? JSONSerialization.jsonObject(with: block.payload, options: []) {
                let data = try! JSONSerialization.data(withJSONObject: json, options: [.sortedKeys, .prettyPrinted])
                let str = String(data: data, encoding: .utf8)!
                cell.prepareViews(content: str)
            }
            else if let str = String(data: block.payload, encoding: .utf8) {
                cell.prepareViews(content: str)
            }
            else {
                cell.prepareViews(content: block.payload.humanReadableSize)
            }
        }
        else if let str = info[keyNames[indexPath.section]] as? String {
            cell.prepareViews(content: str)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }

}

class CommonInfoCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    func prepareViews(content: String) {
        textView.text = content
        textViewHeightConstraint.constant = textView.sizeThatFits(textView.frame.size).height
    }
}
