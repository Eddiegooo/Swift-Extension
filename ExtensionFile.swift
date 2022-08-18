//
//  ExtensionFile.swift
//  TestSwift
//
//  Created by Eddie on 2022/8/18.
//

import UIKit
import SwiftUI

/// 前缀类型
struct QL<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}
// 利用协议扩展前缀属性
protocol ExtensionProtocol {

}
extension ExtensionProtocol {
    // 实例
    var ql: QL<Self> {
        set{
            // 为了让mutating 语法通过
        }
        get { return QL(self) }
    }
    // 类
    static var ql: QL<Self>.Type {
        set{}
        get { QL.self }
    }
}

/// 遵守协议，拥有了前缀属性
extension String: ExtensionProtocol {
    // 本来前缀属性写在这，通用的东西，直接搞一个协议出去，遵循协议即可
//    var ql: QL<String> {
//        return QL(self)
//    }
//
//    static var ql: QL<String>.Type {
//        return QL.self
//    }
}
/// 具体要扩展的内容实现 这里是只给String类型添加扩展
extension QL where Base == String {
    var numCount : Int {
        var count = 0
        for c in base where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    
    static func staticFunction() {
        print("staticFunction")
    }
}
// 如果想给String 和 NSString都添加一样的扩展， 找到他们的共同点
extension NSString : ExtensionProtocol {}
extension QL where Base: ExpressibleByStringLiteral {
    var numCount: Int {
        var count = 0
        // 这里是Swift写法，所以这把base转成String做计算
        for c in (base as! String) where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}



class Person : ExtensionProtocol {

}
class Student: Person{}
/// 具体给Person添加的拓展能力(只要是Person类簇的都可以用)
extension QL where Base: Person{
    var name: String {
        return "Eddiegooo"
    }
    static func test() {
        print("static functions")
    }
}

//Person.ql.test()
//Student.ql.test()
//let p = Person()
//let _ = p.ql.name
//let _ = Student().ql.name
