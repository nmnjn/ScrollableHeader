//
//  CustomViewController.swift
//  ScrollableHeader
//
//  Created by Naman Jain on 10/10/21.
//

import UIKit


class CustomViewController: UIViewController {
    
    let headerHeight: CGFloat = {
        return 200
    }()
    
    var headerView: CustomHeaderView?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: headerHeight, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = .init(top: headerHeight, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        headerView = CustomHeaderView()
        
        guard let headerView = headerView else { return }
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        

    }
    
}



extension CustomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var y = tableView.contentOffset.y + (headerHeight)
        
        // When the table view is scrolled upwards we get positive contentOffset.y and when the table view is scrolled downwards we get a negative contentOffset.y.
        // Since we only want to add upward scrolling on the header, we will take the positive values of contentOffset.y.
        // Try modifying the next line and experimenting with what happens with different values of Y
        
        y = max(y, 0) // y < 0 ? 0 : -y
        
        
        // Here we convert Y into an approximate fraction so that it can be used to alter the opacity of the content in the header.
        self.headerView?.fractionComplete = (y / 200)
        
        // We translate the Header upwards as the tableview is scrolled. We use the negative value of Y because we want to move the header upwards.
        // The 0.5 multiplier is to add a parallax effect while scrolling. If you remove it the header will move upwards at the same speed as the tableView
        self.headerView?.transform = CGAffineTransform(translationX: 0, y: -(y*0.5))
        
    }
    
}
