//
//  VMTranslatorTests.swift
//  VMTranslatorTests
//
//  Created by Gustavo Pirela on 14/10/2018.
//  Copyright © 2018 me. All rights reserved.
//

import XCTest

class CommandTests: XCTestCase {
    
    var sut: Command!
    
    override func setUp() {
        super.setUp()
        sut = Command(command: "add 1 2")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_command_isSetted() {
        XCTAssertEqual(sut.command, "add 1 2")
    }
    
    func test_commandOperator_isSetted() {
        XCTAssertEqual(sut.commandOperator, "add")
    }
    
    func test_commandOperator_whenCommandIsEmpty_isNil() {
        sut.command = ""
        XCTAssertNil(sut.commandOperator)
    }
    
    func test_firstArgument_isSetted() {
        XCTAssertEqual(sut.firstArgument, "1")
    }
    
    func test_firstArgument_whenCommandHasNotFirstArgument_isNil() {
        sut.command = "pop"
        XCTAssertNil(sut.firstArgument)
    }
    
    func test_secondArgument_isSetted() {
        XCTAssertEqual(sut.secondArgument, "2")
    }
    
    func test_secondArgument_whenCommandHasNotSecondArgument_isNil() {
        sut.command = "pop 1"
        XCTAssertNil(sut.secondArgument)
    }
    
    func test_type_whenCommandIsArithmetic_returnArithmeticType() {
        XCTAssertEqual(sut.type, CommandType.arithmetic)
    }
    
    func test_type_whenCommandIsMemoryAccess_returnMemoryAccess() {
        sut.command = "pop local 2"
        XCTAssertEqual(sut.type, CommandType.memoryAccess)
    }
    
    func test_type_whenCommandIsInvalid_returnInvalid() {
        sut.command = "fetch 3 1"
        XCTAssertEqual(sut.type, CommandType.invalid)
        
        sut.command = "pop local 1.2345"
        XCTAssertEqual(sut.type, CommandType.invalid)
        
        sut.command = "add hello 234.432"
        XCTAssertEqual(sut.type, CommandType.invalid)
    }
    
}
