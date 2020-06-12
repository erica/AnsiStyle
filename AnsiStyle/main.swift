//  Created by Erica Sadun on 6/12/20.

import Foundation

let introStyle = ANSIStyle.escape(fg: .cornflowerBlue, styles: [.bold, .reversed])
let infoStyle = ANSIStyle.escape(fg: .cornflowerBlue, styles: [.bold])
let styleReset = ANSIStyle.Style.reset.escaped

print("\(introStyle)Enter text. ^D to finish.\(styleReset)")
var s = ""
while let text = readLine() {
    s += text + "\n"
}
print("")

print("\(infoStyle)You entered:\n\(styleReset)\(s)")
print("\(infoStyle)Stats:\(styleReset)")
let lines = s.components(separatedBy: .newlines)
print("\(lines.count) lines")
let wc = lines
    .filter({ !$0.isEmpty })
    .map({ $0.components(separatedBy: .whitespaces).count })
    .reduce(0, +)
print("\(wc) words")
print("\(s.count) characters")
