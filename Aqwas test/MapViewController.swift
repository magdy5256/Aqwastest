//
//  MapViewController.swift
//  Aqwas test
//
//  Created by 2p on 5/17/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Kingfisher
class MapViewController: UIViewController {
    
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    var myCurrentLocation : CLLocationCoordinate2D!
    
    @IBOutlet weak var resturantRateLbl: UILabel!
    @IBOutlet weak var resturantNameLbl: UILabel!
    var resturant = resturantModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.isMyLocationEnabled = true
        getRestrauntdata()
        self.imageView.isHidden = true
    }
    
    
    
    func getRestrauntdata(){
        var viewModel: ResturantViewModel?
        print(myCurrentLocation.latitude)
        print(myCurrentLocation.longitude)
        self.view.lock()
        viewModel = ResturantViewModel(requestType: "POST", contentType: "application/json", accept: "application/vnd.swipe-v1+json")
        viewModel?.startTheCall(_parameters: [:], urlString:"https://wainnakel.com/api/v1/GenerateFS.php?uid=\(myCurrentLocation.longitude),\(myCurrentLocation.latitude)&get_param=value")
        viewModel?.resturantResult.addObserver(fireNow: false, { (data) in
            print(data!)
            self.view.unlock()
            if data != nil{
                self.resturant = data!
                self.setData()
            }
            
        })
        
    }
    
    @IBAction func imageBtn(_ sender: Any) {
        if self.imageView.isHidden == true{
            
            if resturant.image?.count != 0{
                self.imageView.isHidden = false
                let url = URL(string: resturant.image![0])
                self.resturantImage.kf.setImage(with: url)
            }else{
                let alert = UIAlertController(title: "no image", message: "there is no image for this resturant", preferredStyle: UIAlertController.Style.alert)
                
                
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
            
        }else{
            self.imageView.isHidden = true
        }
    }
    func setData(){
        self.resturantNameLbl.text = resturant.name
        self.resturantRateLbl.text = "\(resturant.rating!) \(resturant.cat!)"
        let camera = GMSCameraPosition.camera(withLatitude: Double(resturant.lat!)!, longitude: Double(resturant.lon!)!, zoom: 6.0)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:Double(resturant.lat!)!, longitude: Double(resturant.lon!)!)
        marker.title = resturant.name
        marker.snippet = "\(resturant.rating!) \(resturant.cat!)"
        marker.map = mapView
    }
    
    @IBAction func newSuggestionBtn(_ sender: Any) {
        mapView.clear()
        self.imageView.isHidden = true
        getRestrauntdata()
    }
}
