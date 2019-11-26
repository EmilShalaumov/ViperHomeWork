//
//  ViperHomeWorkTests.swift
//  ViperHomeWorkTests
//
//  Created by Эмиль Шалаумов on 26.11.2019.
//  Copyright © 2019 Emil Shalaumov. All rights reserved.
//

import XCTest
@testable import ViperHomeWork

class ViperHomeWorkTests: XCTestCase {
    
    var interactor: ImageInteractor!
    var presenterSpy: PresenterSpy!

    override func setUp() {
        presenterSpy = PresenterSpy()
        interactor = ImageInteractor(presenter: presenterSpy, service: ImageServiceMock())
    }

    override func tearDown() {
        presenterSpy = nil
        interactor = nil
    }

    func testThatInteractorClearsCache() {
        // arrange
        interactor.service.imageCache = UIImage()
        
        // act
        interactor.clearCache()
        
        // assert
        XCTAssertNil(interactor.service.imageCache, "Cache was not cleared")
    }
    
    func testThatInteractorShowsImage() {
        // arrange
        interactor.service.imageCache = UIImage()
        
        // act
        interactor.showImageFromCache()
        
        // assert
        XCTAssertEqual(1, presenterSpy.saveImageUpdatesCount, "Image update was not called")
    }
    
    func testThatInteractorDownloadsImage() {
        // arrange
        interactor.service.imageCache = UIImage()
        presenterSpy.testExpectation = self.expectation(description: "Downloading")
        
        // act
        interactor.downloadImage()
        
        // assert
        waitForExpectations(timeout: 0.5, handler: nil)
        XCTAssertEqual("Success", presenterSpy.saveAlertControllerTitle, "Wrong alert controller was shown")
    }
    
    func testThatInteractorFailsImageDownloading() {
        // arrange
        interactor.service.imageCache = nil
        presenterSpy.testExpectation = self.expectation(description: "Downloading")
        
        // act
        interactor.downloadImage()
        
        // assert
        waitForExpectations(timeout: 0.5, handler: nil)
        XCTAssertEqual("Fail", presenterSpy.saveAlertControllerTitle, "Wrong alert controller was shown")
    }

}

class PresenterSpy: ImageInteractorOutput {
    
    var saveImageUpdatesCount = 0
    var saveAlertControllerTitle: String?
    var testExpectation: XCTestExpectation?
    
    func updateImage(image: UIImage) {
        saveImageUpdatesCount += 1
    }
    
    func showAlertController(title: String, message: String) {
        saveAlertControllerTitle = title
        testExpectation?.fulfill()
    }
}

class ImageServiceMock: ImageServiceProtocol {
    var imageCache: UIImage?
    
    func downloadImage(completion: @escaping (UIImage?, Error?) -> Void) {
        completion(imageCache, nil)
    }
    
    
}
