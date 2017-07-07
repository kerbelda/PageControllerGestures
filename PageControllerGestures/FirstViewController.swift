//
//  FirstViewController.swift
//  PageControllerGestures
//
//  Created by Daniel Kerbel on 7/7/17.
//  Copyright © 2017 JustTestingInc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var identity = CGAffineTransform.identity
    
    let textView = UITextView()
    var lastLocation = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanAction))
        panGesture.delegate = self
        textView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(gesture:)))
        pinchGesture.delegate = self
        textView.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture(gesture:)))
        rotateGesture.delegate = self
        textView.addGestureRecognizer(rotateGesture)
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        textView.center = view.center
        textView.text = "Hello World"
        view.addSubview(textView)
    }
    
    //MARK: - Gestures
    
    @objc func handlePanAction(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began, .ended:
            lastLocation = textView.center
        case .changed:
            var translation = gesture.translation(in: view)
            textView.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        default:
            break
        }
    }
    
    @objc func handlePinchGesture(gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            textView.resignFirstResponder()
            identity = textView.transform
        case .changed, .ended:
            textView.transform = identity.scaledBy(x: gesture.scale, y: gesture.scale)
        default:
            break
        }
    }
    
    @objc func handleRotationGesture(gesture: UIRotationGestureRecognizer) {
        print(gesture.rotation)
        textView.transform = textView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
    //MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
