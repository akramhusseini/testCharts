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
        [0.0, 35580.0, 6711.599999999999, 64313.38, 29281.019999999997, 48168.119999999995, 24069.0, 7806.25, 38384.64, 53305.2, 3592.89, 65914.3, 16890.13, 26185.08, 24657.6],
        [0.0, 22230.0, 116037.79999999999, 17309.38, 98102.34, 113482.54, 255849.99000000002, 255626.30000000002, 210974.4, 78066.1, 17587.36, 166328.69999999998, 110082.15000000001, 158292.31, 67679.9],
        [0.0, 60.0, 1025.0, 1060.0, 1130.0, 60.0, 80.0, 120.0, 17.0, 60.0, 120.0, 86.0, 285.0, 139.0, 105.0],
        [0.0, 6081.51552, 57806.2188, 38047.997800000005, 131859.0, 46719.744, 34960.14, 15863.327999999998, 4879.631243999999, 106058.688, 38592.188136000004, 17501.82841, 20016.28314, 8258.37642, 4561.52256, 1590.34161, 5932.978799999999, 2799.3504, 1071.5044679999999, 92097.54918000002, 264917.34225, 10486.039200000001, 96933.62137200002, 11050.3008, 22337.271504, 97901.79503999998, 6755.205600000001, 90927.96854399999, 14065.228800000003],
        [0.0, 2375.592, 9699.03, 25031.577500000003, 13185.9, 5839.968, 8653.5, 2319.2, 854.5763999999999, 20593.92, 10932.631200000002, 2566.2504999999996, 4286.142, 13538.322, 520.128, 177.6918, 792.1199999999999, 519.36, 472.0284, 21980.322, 34271.325, 2688.7280000000005, 14731.553400000003, 2439.36, 2631.0096, 10865.903999999999, 3464.2080000000005, 20116.8072, 2093.0400000000004],
        [0.0, 247.20000000000002, 1666.5, 4592.950000000001, 1365.0, 1219.2, 1350.0, 520.0, 87.38, 4152.0, 3159.7200000000003, 469.15, 703.8, 1751.3999999999999, 67.2, 41.42, 565.8, 432.8, 229.14, 4025.7, 5032.5, 505.40000000000003, 1672.14, 316.8, 1827.09, 1226.3999999999999, 475.20000000000005, 2711.16, 387.6],
        [0.0, 1715.5680000000002, 6549.345, 29624.527500000004, 13226.849999999999, 9314.688, 6250.5, 3484.0, 755.837, 4982.4, 2654.1648, 2153.3985, 3821.6339999999996, 2942.352, 151.87199999999999, 67.5146, 1261.734, 2700.672, 2190.5784, 22423.149, 25363.8, 2501.7300000000005, 5233.7982, 2556.576, 6650.6076, 11197.032, 432.4320000000001, 12227.3316, 918.6120000000001],
        [0.0, 585.864, 11598.84, 13824.7795, 1242.15, 7729.728, 1039.5, 1632.8, 282.2374, 12248.400000000001, 8499.6468, 2158.0899999999997, 5489.639999999999, 9860.382, 185.47199999999998, 74.1418, 2619.6539999999995, 2804.5440000000003, 873.0233999999999, 38485.692, 6995.174999999999, 3168.858, 1036.7268000000001, 2870.208, 4476.3705, 4464.096, 2608.8480000000004, 16998.973199999997, 875.976],
        
        [0.0, 1417.79088, 45699.4296, 64699.96806, 12359.3925, 61915.12128, 5779.62, 5143.32, 1783.740368, 45319.08000000001, 38418.403536, 7531.7341, 27832.4748, 28496.50398, 1810.2067199999997, 172.008976, 20590.480439999996, 15368.901120000002, 2592.879498, 117381.3606, 36025.151249999995, 16826.63598, 3483.4020480000004, 11366.02368, 37153.87515, 38926.91712, 3469.767840000001, 19208.839715999995, 7980.14136],
        [0, 60, 1025, 1060, 1130, 60, 80, 120, 17, 60, 120, 86, 285, 139, 105],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 305, 255, 185, 140, 135, 190, 90, 80, 120, 280, 160 , 190 , 186, 155, 185, 140, 160 ,180, 120],
        [0, 6000, 7140, 7138, 7302, 6006, 8023, 6245, 8704, 6030, 5703, 8605, 7067, 7039, 7005],
        [0, 19000, 17140, 17138, 17302, 16006, 28023, 26245, 28704, 16030, 15703, 18605, 17067, 17039, 17005],
        [0, 60, 550, 485, 140, 160, 180, 200, 17, 600, 402, 55, 85, 420, 35, 19, 60, 80, 201, 497, 550 , 190 , 186, 55, 201, 140, 160, 612, 120],
        [0, 60, 304, 1060, 1130, 60, 80, 345, 17, 60, 346, 345, 56, 34, 76],
        [0, 60, 55, 85, 40, 60, 80, 20, 17, 60, 305, 255, 185, 140, 135, 190, 90, 80, 120, 280, 160 , 190 , 186, 155, 185, 140, 160 ,180, 120],
        [0, 2568, 2545, 2365, 2574, 2667, 2356, 63245, 346, 6030, 5703, 3536, 3375, 6739, 3375],
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? chartTableViewCell else { return }
        let cellData = cell.zigChart.data.map { String(format: "%.2f", $0) }
        
//        print("cellData**")
//        print(cellData)
//        
//        let modelData = data[indexPath.section].map { String(format: "%.2f", $0) }
        print("modelData")
        print(data[indexPath.row])
    }

    
}
