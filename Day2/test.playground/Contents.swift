import UIKit

struct test{
    var myInt: Int {
        return 3
    }
}

var a: Int {
    if test().myInt == 3{return 5}
    else {return 7}
}
print(a)
