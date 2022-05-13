//
//  ViewController.swift
//  udemy_urlsession_sozluk
//
//  Created by Eren Demir on 13.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kelimeTableView: UITableView!
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    var kelimeListesi = [Kelime]()
    override func viewDidLoad() {
        super.viewDidLoad()
        kelimeTableView.delegate = self
        kelimeTableView.dataSource = self
        searchBar.delegate = self
        tumKisiler()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            print("toDetay")
            if let index = sender as? Int{
                let gidilecekVC = segue.destination as! KelimeDetayViewController
                gidilecekVC.kelime = kelimeListesi[index]
            }
        }
    }
    
    func tumKisiler() {
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")!
        URLSession.shared.dataTask(with: url){
            (data,response,error) in
            if error != nil  || data == nil {
                print("Hata: \(error!)")
                return
            }
            do{
                let res = try JSONDecoder().decode(Kelimeler.self, from: data!)
                if let gelenKelimeListesi = res.kelimeler {
                    self.kelimeListesi = gelenKelimeListesi
                }
                DispatchQueue.main.async {
                    self.kelimeTableView.reloadData()
                }
                
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func aramaYap(aramaKelimesi:String) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/sozluk/kelime_ara.php")!)
        request.httpMethod = "POST"
        let postString = "ingilizce=\(aramaKelimesi)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request){
            (data,response,error) in
            if error != nil  || data == nil {
                print("Hata: \(error!)")
                return
            }
            do{
                let res = try JSONDecoder().decode(Kelimeler.self, from: data!)
                if let gelenKelimeListesi = res.kelimeler {
                    self.kelimeListesi = gelenKelimeListesi
                }
                DispatchQueue.main.async {
                    self.kelimeTableView.reloadData()
                }
                
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimeHucre", for: indexPath) as! KelimeHucreTableViewCell
        
        cell.ingilizceLabel.text = kelime.ingilizce
        cell.turkceLabel.text = kelime.turkce
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(print(searchText))
        aramaYap(aramaKelimesi: searchText)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel tıklandı")
    }
    
}
