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
        [0, 60, 550, 485, 140, 160, 180, 200, 17, 600, 402, 55, 85, 420, 35, 19, 60, 80, 201, 497, 550 , 190 , 186, 55, 201, 140, 160, 612, 120],
        [0, 60, 1025, 1060, 1130, 60, 80, 120, 17, 60, 120, 86, 285, 139, 105],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 305, 255, 185, 140, 135, 190, 90, 80, 120, 280, 160 , 190 , 186, 155, 185, 140, 160 ,180, 120],
        [0, 6000, 7140, 7138, 7302, 6006, 8023, 6245, 8704, 6030, 5703, 8605, 7067, 7039, 7005],
        [0, 19000, 17140, 17138, 17302, 16006, 28023, 26245, 28704, 16030, 15703, 18605, 17067, 17039, 17005]]
    
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
