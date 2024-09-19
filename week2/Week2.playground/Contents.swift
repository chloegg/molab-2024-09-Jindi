//: Loading and displaying ascii art from app bundle

import Foundation

func load(_ file: String) -> String {
    let path = Bundle.main.path(forResource: file, ofType: nil)
    let str = try? String(contentsOfFile: path!, encoding: .utf8)
    return str!
}

let part1 = load("flower.txt")
let part2 = load("cake.txt")
let part3 = load("apple.txt")
let part4 = load("icecream.txt")
let part5 = load("chocolate.txt")

let part1Split = part1.split(separator: "\n").map { String($0) }
let part2Split = part2.split(separator: "\n").map { String($0) }
let part3Split = part3.split(separator: "\n").map { String($0) }
let part4Split = part4.split(separator: "\n").map { String($0) }
let part5Split = part5.split(separator: "\n").map { String($0) }

func combine(_ part1: [String], _ part2: [String], _ margin: Int, alignBottom: Bool = false) -> [String] {
    let bmax = part1.map { $0.count }.max()!
    let edge = bmax + margin
    
    // check the align
    var alignedPart1 = part1
    var alignedPart2 = part2
    
    if alignBottom {
        if alignedPart1.count < alignedPart2.count {
            let padding = Array(repeating: "", count: alignedPart2.count - alignedPart1.count)
            alignedPart1.insert(contentsOf: padding, at: 0) //add line top
        } else if alignedPart2.count < alignedPart1.count {
            let padding = Array(repeating: "", count: alignedPart1.count - alignedPart2.count)
            alignedPart2.insert(contentsOf: padding, at: 0)
        }
    } else {
        if alignedPart1.count < alignedPart2.count {
            alignedPart1.append(contentsOf: Array(repeating: "", count: alignedPart2.count - alignedPart1.count)) //add line bottom
        } else if alignedPart2.count < alignedPart1.count {
            alignedPart2.append(contentsOf: Array(repeating: "", count: alignedPart1.count - alignedPart2.count))
        }
    }
    
    var arr: [String] = []
    for index in 0..<alignedPart1.count {
        var line1 = alignedPart1[index]
        line1 += String(repeating: " ", count: edge - line1.count)
        var line2 = ""
        if index < alignedPart2.count {
            line2 = String(alignedPart2[index])
        }
        arr.append(line1 + line2)
    }
    return arr
}

let combo1 = combine(part1Split, part2Split, 1)
let combo2 = combine(combo1, part3Split, 1)
let combo3 = combine(combo2, part4Split, 1, alignBottom: true)
let combo4 = combine(combo3, part5Split, 1, alignBottom: true)

let finalStr = combo4.joined(separator: "\n")
print(finalStr)




// Source:
// https://asciiart.website/index.php?art=food%20and%20drink/apples
