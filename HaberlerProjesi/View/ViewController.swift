//
//  ViewController.swift
//  HaberlerProjesi
//
//  Created by Ezgi  on 30.04.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var newsTableViewModel : NewsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension  //labellerın yüksekliğini ayarlar.
        tableView.estimatedRowHeight = UITableView.automaticDimension // tahmin edilen yükseklik , yani boyutları dinamik olacak.
        
      veriAl()
        
        
        // Do any additional setup after loading the view.
    }
    
    func veriAl () {
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/BTK-iOSDataSet/master/dataset.json")
        
        WebService().haberleriIndir(url: url!) { (haberler) in
            if let haberler = haberler {
                
                self.newsTableViewModel = NewsTableViewModel(newsList: haberler)
                DispatchQueue.main.async { // asenkron bir şekilde yapılmasını saglıyor
                
                    self.tableView.reloadData()
                }
               
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsTableViewModel == nil ? 0 : self.newsTableViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewCell
        let newsViewModel = self.newsTableViewModel.newsAtIndexPath(indexPath.row)
        cell.titleLabel.text = newsViewModel.title
        cell.storyLabel.text = newsViewModel.story
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // yukarıda tanımlanan heightları çagırıyoruz.
        return UITableView.automaticDimension
        
    }
    
}


