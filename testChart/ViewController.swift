//
//  ViewController.swift
//  testChart
//
//  Created by Akram Husseini on 18/01/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! { didSet{
        tableView.register(UINib(nibName: "chartTableViewCell", bundle: nil), forCellReuseIdentifier: "chartTableViewCell")
    }}
    let chartHeight: CGFloat = 108
    var chartWidth: CGFloat = UIScreen.main.bounds.width - 32
    
    let data: [[CGFloat]] = [
        [0, 60, 550, 485, 140, 160, 180, 200, 17, 600, 1029, 55, 85, 420, 35, 19, 60, 80, 201, 497, 550 , 190 , 186, 55, 201, 140, 160, 1320, 120],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 120, 195, 285, 220, 105],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 100, 55, 85, 40, 35, 19, 60, 80, 20, 0, 60 , 90 , 86, 55, 85, 40, 60, 80, 20]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartTableViewCell", for: indexPath) as! chartTableViewCell
        cell.initView(newData: data[indexPath.row])
        return cell
    }
}
