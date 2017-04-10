//
//  ViewController.swift
//  gyro_cencer
//
//  Created by 桐山圭祐 on 2017/04/10.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var xAxisLabel: UILabel!
    @IBOutlet weak var yAxisLabel: UILabel!
    @IBOutlet weak var zAxisLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var gyro_img: UIImageView!
    var motion: CMMotionManager!
    var mode = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.gyro_img.image = UIImage(named: "gyro.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accelerationButton(_ sender: Any) {
        self.mode = 0
        self.xLabel.text = "Xaxis"
        self.yLabel.text = "Yaxis"
        self.zLabel.text = "Zaxis"
        self.gyro_img.image = UIImage(named: "acce.png")
    }
    
    @IBAction func gyroButton(_ sender: Any) {
        self.mode = 1
        self.xLabel.text = "Xaxis"
        self.yLabel.text = "Yaxis"
        self.zLabel.text = "Zaxis"
        self.gyro_img.image = UIImage(named: "gyro.jpg")
    }
    
    @IBAction func postureButton(_ sender: Any) {
        self.mode = 2
        self.xLabel.text = "roll"
        self.yLabel.text = "pitch"
        self.zLabel.text = "yaw"
        self.gyro_img.image = UIImage(named:"posture.png")
    }
    

    @IBAction func startGetGyro(_ sender: Any) {
        motion = CMMotionManager()
        motion.deviceMotionUpdateInterval = 0.1
        motion.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { deviceManager, error in
            let accel:CMAcceleration = (deviceManager?.userAcceleration)!
            let gyro:CMRotationRate = (deviceManager?.rotationRate)!
            let attitude: CMAttitude = (deviceManager?.attitude)!
            if self.mode == 0{
                self.xAxisLabel.text = String(format: "%.3f", (accel.x))
                self.yAxisLabel.text = String(format: "%.3f", (accel.y))
                self.zAxisLabel.text = String(format: "%.3f", (accel.z))
            }else if self.mode == 1{
                self.xAxisLabel.text = String(format: "%.3f", (gyro.x))
                self.yAxisLabel.text = String(format: "%.3f", (gyro.y))
                self.zAxisLabel.text = String(format: "%.3f", (gyro.z))
            }else if self.mode == 2{
                self.xAxisLabel.text = String(format: "%.3f", (attitude.roll))
                self.yAxisLabel.text = String(format: "%.3f", (attitude.pitch))
                self.zAxisLabel.text = String(format: "%.3f", (attitude.yaw))
            }
            
        })
        
        
        
//        motion = CMMotionManager()
//        if motion.isAccelerometerAvailable{
//            motion.accelerometerUpdateInterval = 0.1
//            motion.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
//                self.xAxisLabel.text = String(format: "%.3f", (data?.acceleration.x)!)
//                self.yAxisLabel.text = String(format: "%.3f", (data?.acceleration.y)!)
//                self.zAxisLabel.text = String(format: "%.3f", (data?.acceleration.z)!)
//            })
//        }
    }

    @IBAction func stopGetGyro(_ sender: Any) {
        motion.stopAccelerometerUpdates()
    }
    
}

