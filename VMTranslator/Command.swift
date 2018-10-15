//
//  Command.swift
//  VMTranslator
//
//  Created by Gustavo Pirela on 14/10/2018.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

enum CommandType {
    case arithmetic
    case memoryAccess
    case invalid
}

enum ArithmeticCommand: String {
    case addition     = "add"
    case substraction = "sub"
    case negate       = "neg"
    case equality     = "eq"
    case greaterThan  = "gt"
    case lessThan     = "lt"
    case and          = "and"
    case or           = "or"
    case not          = "not"
}

enum MemoryAccessCommand: String {
    case push
    case pop
}

enum MemorySegment: String {
    case argument
    case local
    case staticSegment = "static"
    case constant
    case this
    case that
    case pointer
    case temp
}

struct Command {
    
    var command: String {
        didSet {
            self.tokens = command.split(separator: " ").map {return String($0)}
        }
    }
    
    // MARK: - Computed Properties
    
    lazy var type = { return setCommandType() }()
    var commandOperator: String? { return tokens.count >= 1 ? tokens[0] : nil }
    var firstArgument:   String? { return tokens.count >= 2 ? tokens[1] : nil }
    var secondArgument:  String? { return tokens.count >= 3 ? tokens[2] : nil }
    
    // MARK: - Init
    
    init(command: String) {
        self.command = command
        self.tokens = command.split(separator: " ").map {return String($0)}
    }
    
    // MARK: - Private
    
    private var tokens: [String]!
    
    private func setCommandType() -> CommandType {
        if isArithmeticCommand() {
            return .arithmetic
        } else if isMemoryAccessCommand() {
            return .memoryAccess
        }
        
        return .invalid
    }
    
    private func isArithmeticCommand() -> Bool {
        guard let commandOperator = commandOperator, let firstArgument = firstArgument else {
            return false
        }
        
        let isArithmethicOperator = (ArithmeticCommand(rawValue: commandOperator) != nil)
        let isFirstArgumentInteger = (Int(firstArgument) != nil)
        var isSecondArgumentInteger = false
        
        if let secondArgument = secondArgument {
            isSecondArgumentInteger = (Int(secondArgument) != nil)
            return isArithmethicOperator && isFirstArgumentInteger && isSecondArgumentInteger
        } else {
            return isArithmethicOperator && isFirstArgumentInteger
        }
    }
    
    private func isMemoryAccessCommand() -> Bool {
        guard let commandOperator = commandOperator,
            let firstArgument = firstArgument,
            let secondArgument = secondArgument else {
            return false
        }
        
        let isMemoryAccessOperator  = (MemoryAccessCommand(rawValue: commandOperator) != nil)
        let isFirstArgumentMemorySegment = (MemorySegment(rawValue: firstArgument) != nil)
        let isSecondArgumentInteger = (Int(secondArgument) != nil)
        
        return isMemoryAccessOperator && isFirstArgumentMemorySegment && isSecondArgumentInteger
    }
}
