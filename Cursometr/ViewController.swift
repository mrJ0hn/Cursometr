//
//  ViewController.swift
//  Cursometr
//
//  Created by iMacAir on 08.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit


//class ViewController: UIViewController, UIPageViewControllerDataSource {
//    
//    var pageViewController: UIPageViewController?
//    //var activityIndicator = UIActivityIndicatorView()
//    var currencies : [Currency] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        activityIndicator.center = self.view.center
////        activityIndicator.hidesWhenStopped = true
////        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
////        view.addSubview(activityIndicator)
//        
//        updateData()
//        BankDataDownloadService.shared.startLoadingCurrencySubscription = startLoading
//        BankDataDownloadService.shared.finishLoadingCurrencySubscription = updateData
//        createPageViewController()
//        setupPageControl()
//        
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    func startLoading(){
//        //activityIndicator.startAnimating()
//    }
//    
//    func stopLoading(){
//        //activityIndicator.stopAnimating()
//    }
//    
//    func updateData(needUpdate: Bool = true){
//        if needUpdate{
//            BankDataDownloadService.shared.getCurrencySubscription(onSuccess: { [weak self] (currencies) in
//                DispatchQueue.main.async {
//                    self?.currencies = currencies
//                    self?.updatePageViewController()
//                    self?.stopLoading()
//                }
//            })
//        }
//    }
//    
//    func updatePageViewController(){
//        self.pageViewController?.setViewControllers([getItemController(0)], direction: .forward, animated: false, completion: nil)
//    }
//    
//    func createPageViewController(){
//        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
//        pageController.dataSource = self
//        
//        updatePageViewController()
//        
//        pageViewController = pageController
//        addChildViewController(pageViewController!)
//        self.view.addSubview(pageViewController!.view)
//        pageViewController?.didMove(toParentViewController: self)
//    }
//    
//    func setupPageControl(){
//        //set custom settings for page controller
//    }
//    
//    //swipe to left
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        let itemController = viewController as! ItemViewController
//        if (itemController.itemIndex > 0)
//        {
//            return getItemController(itemController.itemIndex-1)
//        }
//        return nil
//    }
//    
//    //swipe to right
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let itemController = viewController as! ItemViewController
//        if (itemController.itemIndex + 1 < currencies.count)
//        {
//            return getItemController(itemController.itemIndex + 1)
//        }
//        return nil
//    }
//    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return currencies.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//    
//    func currentController() -> UIViewController? {
//        if (self.pageViewController?.viewControllers?.count)! > 0 {
//            return self.pageViewController?.viewControllers![0]
//        }
//        return nil
//    }
//    
//    func getItemController(_ itemIndex: Int) -> ItemViewController {
//        if (itemIndex < currencies.count){
//            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
//            pageItemController.itemIndex = itemIndex
//            pageItemController.setConfig(currency: currencies[itemIndex])
//            return pageItemController
//        }
//        else{
//            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
//            pageItemController.itemIndex = itemIndex
//            pageItemController.setConfig(title: "No currency")
//            return pageItemController
//        }
//    }
//}
//
