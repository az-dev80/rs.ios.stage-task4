import Foundation

public extension Int {
    
    var roman: String? {
        var number = self
        if (number < 1) {return nil}
        var str = ""
        let dict: [(Int, String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        for i in dict {
            while (number >= i.0) {
                number -= i.0
                str += i.1
                    }
                }
        return str
    }
}
