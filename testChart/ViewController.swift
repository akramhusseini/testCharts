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
    var chartWidth: CGFloat = UIScreen.main.bounds.width - 32
    
    let origionalData: [[CGFloat]] = [
        [169, 60, 550, 485, 140, 160, 180, 200, 17, 600, 402, 55, 85, 420, 35, 19, 60, 80, 201, 497, 550 , 190 , 186, 55, 201, 140, 160, 612, 120],
        [0, 60, 1025, 1060, 1130, 60, 80, 120, 17, 60, 120, 86, 285, 139, 105],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 305, 255, 185, 140, 135, 190, 90, 80, 120, 280, 160 , 190 , 186, 155, 185, 140, 160 ,180, 120],
        [0, 6000, 7140, 7138, 7302, 6006, 8023, 6245, 8704, 6030, 5703, 8605, 7067, 7039, 7005],
        [0, 19000, 17140, 17138, 17302, 16006, 28023, 26245, 28704, 16030, 15703, 18605, 17067, 17039, 17005],
        [169, 60, 550, 485, 140, 160, 180, 200, 17, 600, 402, 55, 85, 420, 35, 19, 60, 80, 201, 497, 550 , 190 , 186, 55, 201, 140, 160, 612, 120],
        [0, 60, 304, 1060, 1130, 60, 80, 345, 17, 60, 346, 345, 56, 34, 76],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 305, 255, 185, 140, 135, 190, 90, 80, 120, 280, 160 , 190 , 186, 155, 185, 140, 160 ,180, 120],
        [50, 568, 545, 365, 574, 667, 356, 63245, 346, 6030, 5703, 3536, 3375, 6739, 3375],
        [0, 195400, 46675, 167138, 177302, 168006, 284023, 262845, 248704, 160730, 157043, 186075, 170647, 170379, 170405]]
    
    var data: [[CGFloat]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPullToRandomimze()
        //randomize()
        data = origionalData
    }

    private func randomize() {
        data = origionalData.applyingRandomMultipliers()
    }
    
    private func setupPullToRandomimze() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        randomize()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
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
