import Cocoa

let triheight = 5

func printTriangle(height: Int) {
    for i in 1...height {
        let spaces = String(repeating: "  ", count: height - i)
        let triangle = String(repeating: "⬜️", count: 2 * i - 1)
        print(spaces + triangle)
    }
}

printTriangle(height: triheight)
let sideLength = 9

func printSquare(sideLength: Int) {
    for i in 1...sideLength {
        for j in 1...sideLength {
            if i == sideLength && j == sideLength{
                print("🟪  🌷", terminator: "")
            } else if i == 1 || i == sideLength || j == 1 || j == sideLength {
                print("🟪", terminator: "")
            } else if i >= sideLength - 2 && j == (sideLength + 1)/2{
                print("⬜️", terminator: "")
            } else {
                print("⬛️", terminator: "")
            }
        }
        print("")
    }
    print(String(repeating: "🟩", count: sideLength + 2))
}

printSquare(sideLength: sideLength)


