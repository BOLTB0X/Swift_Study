import Foundation

/*
 * Complete the 'plusMinus' function below.
 *
 * The function accepts INTEGER_ARRAY arr as parameter.
 */

// https://www.hackerrank.com/challenges/one-month-preparation-kit-plus-minus/problem?isFullScreen=true&h_l=interview&playlist_slugs%5B%5D=preparation-kits&playlist_slugs%5B%5D=one-month-preparation-kit&playlist_slugs%5B%5D=one-month-week-one
func plusMinus(arr: [Int]) -> Void {
    // Write your code here
    
    var plusCnt:Int = 0
    var minusCnt:Int = 0
    
    for i in 0..<arr.count {
        if arr[i] > 0 {
            plusCnt += 1
        } else if arr[i] < 0 {
            minusCnt += 1
        } 
    }
    
    print(Double(plusCnt)/Double(arr.count))
    print(Double(minusCnt)/Double(arr.count))
    print(Double((arr.count-plusCnt-minusCnt))/Double(arr.count))
}

guard let n = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

guard let arrTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let arr: [Int] = arrTemp.split(separator: " ").map {
    if let arrItem = Int($0) {
        return arrItem
    } else { fatalError("Bad input") }
}

guard arr.count == n else { fatalError("Bad input") }

plusMinus(arr: arr)

