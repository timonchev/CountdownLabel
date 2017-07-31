//
//  CountdownLabelExampleTests.swift
//  CountdownLabelExampleTests
//
//  Created by suzuki keishi on 2016/01/08.
//  Copyright © 2016 suzuki_keishi. All rights reserved.
//

import XCTest
@testable import CountdownLabel

class CountdownLabelExampleTests: XCTestCase {
    
    func testInitWithCoder() {
        let storyboard = UIStoryboard(name: "StoryboardTests", bundle: Bundle(for: type(of: self)))
        let vc = storyboard.instantiateInitialViewController()
        XCTAssertNotNil(vc)
        XCTAssertEqual(vc?.view.subviews.count, 3)
    }
    
    func testInitWithFrame() {
        let label = CountdownLabel()
        
        XCTAssertNotNil(label)
    }
    
    func testStartStatus() {
        let label = CountdownLabel(frame: CGRect.zero, minutes: 30)
        label.start()
        
        XCTAssertEqual(label.isCounting, true)
        XCTAssertEqual(label.isPaused, false)
        XCTAssertEqual(label.timeFormat, "HH:mm:ss")
        XCTAssertEqual(label.morphingEnabled, false)
    }
    
    func testStartWithMorphing() {
        let label = CountdownLabel(frame: CGRect.zero, minutes: 30)
        label.animationType = .Fall
        label.start()
        
        XCTAssertEqual(label.isCounting, true)
        XCTAssertEqual(label.isPaused, false)
        XCTAssertEqual(label.timeFormat, "HH:mm:ss")
        XCTAssertEqual(label.morphingEnabled, true)
    }
    
    func testSettingCountdownTime() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes: 30)
        label.start()
        label.pause()
        
        XCTAssertEqual(label.isCounting, false)
        XCTAssertEqual(label.isPaused, true)
        XCTAssertEqual(label.isFinished, false)
        XCTAssertEqual(label.timeCounted.int, 0)
        XCTAssertEqual(label.timeRemaining.int, 30)
    }
    
    func testSettingCountdownDate() {
        let label = CountdownLabel(frame: CGRect.zero, date: Date().addingTimeInterval(30))
        label.start()
        label.pause()
        
        XCTAssertEqual(label.isCounting, false)
        XCTAssertEqual(label.isPaused, true)
        XCTAssertEqual(label.isFinished, false)
        XCTAssertEqual(label.timeCounted.int, 0)
        XCTAssertEqual(label.timeRemaining.int, 30)
    }
    
    func testSettingCountdownDateScheduled() {
        let fromDate   = Date().addingTimeInterval(10)
        let targetDate = Date().addingTimeInterval(20)
        let label = CountdownLabel(frame: CGRect.zero, fromDate: fromDate, targetDate: targetDate)
        
        label.start()
        label.pause()
        
        let xpectation = expectation(description:"expect")
        delay(delay: 2.0) {
            label.pause()
            
            XCTAssertEqual(label.isCounting, false)
            XCTAssertEqual(label.isPaused, true)
            XCTAssertEqual(label.isFinished, false)
            XCTAssertEqual(label.timeCounted.int, 0)
            XCTAssertEqual(label.timeRemaining.int, 10)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:3.0, handler: nil)
    }
    
    func testPauseStatus() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes: 30)
        label.start()
        label.pause()
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.0) {
            
            XCTAssertEqual(label.isCounting, false)
            XCTAssertEqual(label.isPaused, true)
            XCTAssertEqual(label.isFinished, false)
            XCTAssertEqual(label.timeCounted.int, 1)
            XCTAssertEqual(label.timeRemaining.int, 29)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    func testRestart() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes: 30)
        label.start()
        label.pause()
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.0) {
            label.start()
            
            XCTAssertEqual(label.isCounting, true)
            XCTAssertEqual(label.isPaused, false)
            XCTAssertEqual(label.isFinished, false)
            XCTAssertEqual(label.timeCounted.int, 0)
            XCTAssertEqual(label.timeRemaining.int, 30)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    func testAfterASecond() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes:30)
        label.start()
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.0) {
            label.pause()
            
            XCTAssertEqual(label.isCounting, false)
            XCTAssertEqual(label.isPaused, true)
            XCTAssertEqual(label.isFinished, false)
            XCTAssertEqual(label.timeCounted.int, 1)
            XCTAssertEqual(label.timeRemaining.int, 29)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    func testAfterASecondDate() {
        let label = CountdownLabel()
        
        let targetDate = Date().addingTimeInterval(30)
        label.setCountDownDate(targetDate: targetDate)
        label.start()
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.1) {
            label.pause()
            
            XCTAssertEqual(label.isCounting, false)
            XCTAssertEqual(label.isPaused, true)
            XCTAssertEqual(label.isFinished, false)
            XCTAssertEqual(label.timeCounted.int, 1)
            XCTAssertEqual(label.timeRemaining.int, 29)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    func testAddTime() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes: 30)
        label.start()
        label.pause()
        label.addTime(time: 1)
        
        XCTAssertEqual(label.timeCounted.int, 0)
        XCTAssertEqual(label.timeRemaining.int, 31)
    }
    
    func testMinusTime() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes: 30)
        label.start()
        label.pause()
        label.addTime(time: -1)
        
        XCTAssertEqual(label.timeCounted.int, 0)
        XCTAssertEqual(label.timeRemaining.int, 29)
    }
    
    func testCountdownisFinished() {
        let label = CountdownLabel()
        
        label.setCountDownTime(minutes: 1)
        label.start()
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.1) {
            
            XCTAssertEqual(label.isFinished, true)
            XCTAssertEqual(label.isCounting, false)
            XCTAssertEqual(label.isPaused, false)
            XCTAssertEqual(label.timeCounted.int, 1)
            XCTAssertEqual(label.timeRemaining.int, 0)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    func testCountdownisFinishedWithCompletion() {
        let label = CountdownLabel()
        
        var completionChangedValue = 1
        label.setCountDownTime(minutes: 1)
        label.start() {
            completionChangedValue = 2
        }
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.1) {
            
            XCTAssertEqual(completionChangedValue, 2)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    func testCountdownThen() {
        let label = CountdownLabel()
        
        var completionChangedValue = 1
        label.setCountDownTime(minutes: 10)
        let _ = label.then(targetTime: 9) {
            completionChangedValue = completionChangedValue + 1
        }
        let _ = label.then(targetTime: 8) {
            completionChangedValue = completionChangedValue + 2
        }
        label.start()
        
        let xpectation = expectation(description:"expect")
        delay(delay:2.1) {
            XCTAssertEqual(completionChangedValue, 4)
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:3.0, handler: nil)
    }
    
    func testAttributedText() {
        let label = CountdownLabel()
        label.setCountDownTime(minutes: 10)
        label.countdownAttributedText = CountdownAttributedText(text: "HELLO TIME IS HERE NOW",
            replacement: "HERE",
            attributes: [NSForegroundColorAttributeName: UIColor.red])
        label.start()
        
        XCTAssertEqual(label.attributedText!.string, "HELLO TIME IS 00:00:10 NOW")
    }
    
    func testAttributedTextScheduled() {
        let fromDate   = Date().addingTimeInterval(10)
        let targetDate = fromDate.addingTimeInterval(30)
        let label = CountdownLabel(frame: CGRect.zero, fromDate: fromDate, targetDate: targetDate)
        label.countdownAttributedText = CountdownAttributedText(text: "HELLO TIME IS HERE NOW",
            replacement: "HERE",
            attributes: [NSForegroundColorAttributeName: UIColor.red])
        label.start()
        
        
        let xpectation = expectation(description:"expect")
        delay(delay: 1.0) {
            label.pause()
            
            XCTAssertEqual(label.isCounting, false)
            XCTAssertEqual(label.isPaused, true)
            XCTAssertEqual(label.isFinished, false)
            XCTAssertEqual(label.timeCounted.int, 0)
            XCTAssertEqual(label.timeRemaining.int, 30)
            XCTAssertEqual(label.attributedText!.string, "HELLO TIME IS 00:00:30 NOW")
            
            xpectation.fulfill()
        }
        
        waitForExpectations(timeout:2.0, handler: nil)
    }
    
    
    // MARK: - Unexpect inserting
    func testMinutesZero() {
        let label = CountdownLabel(frame: CGRect.zero, minutes: 0)
        label.start()
        
        XCTAssertEqual(label.text, "00:00:00")
        XCTAssertEqual(label.isCounting, false)
        XCTAssertEqual(label.isPaused, false)
        XCTAssertEqual(label.isFinished, true)
    }
    
    func testMinutesMinus() {
        let label = CountdownLabel(frame: CGRect.zero, minutes: -1)
        label.start()
        
        XCTAssertEqual(label.text, "00:00:00")
        XCTAssertEqual(label.isCounting, false)
        XCTAssertEqual(label.isPaused, false)
        XCTAssertEqual(label.isFinished, true)
    }
    
    func testMorphingStatus() {
        let label = CountdownLabel(frame: CGRect.zero, minutes: 30)
        
        XCTAssertEqual(label.morphingEnabled, false)
        
        // see example
        label.animationType = .Anvil
        label.animationType = .Burn
        label.animationType = .Evaporate
        label.animationType = .Fall
        label.animationType = .Pixelate
        label.animationType = .Scale
        label.animationType = .Sparkle
        label.start()
        
        XCTAssertEqual(label.morphingEnabled, true)
        
        label.pause()
        label.animationType = .none
        label.start()
        
        XCTAssertEqual(label.morphingEnabled, false)
    }
    
    func delay(delay: Double, closure: @escaping ()->()) {
        
        
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC);
        DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
    }
}
