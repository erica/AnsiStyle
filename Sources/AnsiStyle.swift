//  Copyright © 2020 Erica Sadun. All rights reserved.
//
// See https://en.wikipedia.org/wiki/ANSI_escape_code

import Foundation

/// A type that can be combined into a merge style sequence
public protocol ANSIStylable {
    var rawValue: Int { get }
    var escaped: String { get }
}

/// A namespace for standard ANSI style utility
public enum ANSIStyle {
    public static let esc = "\u{001B}["
    public static let unescape = "m"
    
    /// Return an escaped sequence representing the submitted style entries
    public static func escape(_ styling: [ANSIStylable]) -> String {
        let escape = "\u{001B}["
        let unescape = "m"
        return
            escape
                + styling
                    .map({ String($0.rawValue) })
                    .joined(separator: ";")
                + unescape
    }
    
    /// Style characteristics such as bold, dim, etc
    public enum Style: Int, ANSIStylable {
        public var escapeValue: String { "0;\(self.rawValue)" }
        public var escaped: String { "\u{001B}[0;\(self.escapeValue)m" }
        case reset = 0, bold, dim, italic, blink = 5, reversed = 7
    }
    
    /// Core color characteristics
    public enum Color: Int, ANSIStylable {
        public var escapeValue: String { "0;\(self.rawValue)" }
        public var escaped: String { "\u{001B}[0;\(self.escapeValue)m" }
        case fgBlack = 30, fgRed, fgGreen, fgYellow, fgBlue, fgMagenta, fgCyan, fgLightGray
        case fgDarkGray = 90, fgLightRed, fgLightGreen, fgLightYellow, fgLightBlue, fgLightMagenta, fgLightCyan, fgWhite
        case bgBlack = 40, bgRed, bgGreen, bgYellow, bgBlue, bgMagenta, bgCyan, bgLightGray
        case bgDarkGray = 100, bgLightRed, bgLightGreen, bgLightYellow, bgLightBlue, bgLightMagenta, bgLightCyan, bgWhite
    }
    
    /// Return an escape sequence for fg color, bg color, and styling
    /// - Parameters:
    ///   - fg: foreground LUT color
    ///   - bg: background LUT color
    ///   - styles: styles to apply
    /// - Returns: an escape string
    public static func escape(fg: LUTColor?, bg: LUTColor? = nil, styles: [Style] = []) -> String {
        let styling = escape(styles)
        let fgStyle = fg.flatMap ({ "\(esc)38;5;\($0.rawValue)m" }) ?? ""
        let bgStyle = bg.flatMap ({ "\(esc)48;5;\($0.rawValue)m" }) ?? ""
        return styling + fgStyle + bgStyle
    }
    
    /// Extended color indices for the 256-entry lookup table colors
    ///
    /// The names are via https://jonasjacek.github.io/colors/
    public enum LUTColor: Int {
        case black = 0, maroon, green, olive, navy, purple, teal, silver, gray, red, lime, yellow, blue, fuchsia, aqua, white, gray0, navyBlue, darkBlue, blue3, blue3_2, blue1, darkGreen, deepSkyBlue4, deepSkyBlue4_2, deepSkyBlue4_3, dodgerBlue3, dodgerBlue2, green4, springGreen4, turquoise4, deepSkyBlue3, deepSkyBlue3_2, dodgerBlue1, green3, springGreen3, darkCyan, lightSeaGreen, deepSkyBlue2, deepSkyBlue1, green3_2, springGreen3_2, springGreen2, cyan3, darkTurquoise, turquoise2, green1, springGreen2_2, springGreen1, mediumSpringGreen, cyan2, cyan1, darkRed, deepPink4, purple4, purple4_2, purple3, blueViolet, orange4, gray37, mediumPurple4, slateBlue3, slateBlue3_2, royalBlue1, chartreuse4, darkSeaGreen4, paleTurquoise4, steelBlue, steelBlue3, cornflowerBlue, chartreuse3, darkSeaGreen4_2, cadetBlue, cadetBlue_2, skyBlue3, steelBlue1, chartreuse3_2, paleGreen3, seaGreen3, aquamarine3, mediumTurquoise, steelBlue1_2, chartreuse2, seaGreen2, seaGreen1, seaGreen1_2, aquamarine1, darkSlateGray2, darkRed_2, deepPink4_2, darkMagenta, darkMagenta_2, darkViolet, purple_2, orange4_2, lightPink4, plum4, mediumPurple3, mediumPurple3_2, slateBlue1, yellow4, wheat4, gray53, lightSlateGray, mediumPurple, lightSlateBlue, yellow4_2, darkOliveGreen3, darkSeaGreen, lightSkyBlue3, lightSkyBlue3_2, skyBlue2, chartreuse2_2, darkOliveGreen3_2, paleGreen3_2, darkSeaGreen3, darkSlateGray3, skyBlue1, chartreuse1, lightGreen, lightGreen_2, paleGreen1, aquamarine1_2, darkSlateGray1, red3, deepPink4_3, mediumVioletRed, magenta3, darkViolet_2, purple_3, darkOrange3, indianRed, hotPink3, mediumOrchid3, mediumOrchid, mediumPurple2, darkGoldenrod, lightSalmon3, rosyBrown, gray63, mediumPurple2_2, mediumPurple1, gold3, darkKhaki, navajoWhite3, gray69, lightSteelBlue3, lightSteelBlue, yellow3, darkOliveGreen3_3, darkSeaGreen3_2, darkSeaGreen2, lightCyan3, lightSkyBlue1, greenYellow, darkOliveGreen2, paleGreen1_2, darkSeaGreen2_2, darkSeaGreen1, paleTurquoise1, red3_2, deepPink3, deepPink3_2, magenta3_2, magenta3_3, magenta2, darkOrange3_2, indianRed_2, hotPink3_2, hotPink2, orchid, mediumOrchid1, orange3, lightSalmon3_2, lightPink3, pink3, plum3, violet, gold3_2, lightGoldenrod3, tan, mistyRose3, thistle3, plum2, yellow3_2, khaki3, lightGoldenrod2, lightYellow3, gray84, lightSteelBlue1, yellow2, darkOliveGreen1, darkOliveGreen1_2, darkSeaGreen1_2, honeydew2, lightCyan1, red1, deepPink2, deepPink1, deepPink1_2, magenta2_2, magenta1, orangeRed1, indianRed1, indianRed1_2, hotPink, hotPink_2, mediumOrchid1_2, darkOrange, salmon1, lightCoral, paleVioletRed1, orchid2, orchid1, orange1, sandyBrown, lightSalmon1, lightPink1, pink1, plum1, gold1, lightGoldenrod2_2, lightGoldenrod2_3, navajoWhite1, mistyRose1, thistle1, yellow1, lightGoldenrod1, khaki1, wheat1, cornsilk1, gray100, gray3, gray7, gray11, gray15, gray19, gray23, gray27, gray30, gray35, gray39, gray42, gray46, gray50, gray54, gray58, gray62, gray66, gray70, gray74, gray78, gray82, gray85, gray89, gray93
    }
}
