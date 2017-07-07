//
//  ViewController.swift
//  PageControllerGestures
//
//  Created by Daniel Kerbel on 7/7/17.
//  Copyright © 2017 JustTestingInc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentPageIndex = 0
    var pageViewController: UIPageViewController!
    var viewControllerList: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        let options = [UIPageViewControllerOptionInterPageSpacingKey : 10]
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal , options: options)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.backgroundColor = UIColor.black
        
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        viewControllerList = [firstVC, secondVC]
        let pagesArray = [firstVC]
        pageViewController.setViewControllers(pagesArray, direction: .forward, animated: false, completion: nil)
        
        pageViewController.view.frame = self.view.bounds
        
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }

}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList?.index(of: viewController) else { return nil }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard (viewControllerList?.count)! > previousIndex else { return nil }
        
        return viewControllerList?[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList?.index(of: viewController) else { return nil }
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList?.count != nextIndex else { return nil }
        
        guard (viewControllerList?.count)! > nextIndex else { return nil }
        
        return viewControllerList?[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let vc = pageViewController.viewControllers?.first
            let index = viewControllerList?.index(of: vc!)
            currentPageIndex = index!
        }
    }
}
