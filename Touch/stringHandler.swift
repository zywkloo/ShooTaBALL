//
//  stringHandler.swift
//  Recursion
//
//  Created by 张一唯 on 2019-03-20.
//  Copyright © 2019 Yiwei. All rights reserved.
//

import Foundation

class StringHandler{

    static func isPalindrome(input: String) -> Bool {  //helper func to check a string isPalindrome
        let in1st = input.startIndex
        let in2nd = input.index(after: input.startIndex)
        let inLast = input.index(before: input.endIndex)
        let startChr:Character = input[in1st]
        let endChr:Character = input[inLast]
        if (input.count == 0 || input.count == 1 ) { return true }
        else {
            return startChr == endChr ? isPalindrome( input: String(input[in2nd..<inLast]) ):false
        }
    }

}
