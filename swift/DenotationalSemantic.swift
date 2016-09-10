// Denotational semantic, transform programming language into another format, most common scenario is mathematical format

// But here we transform 'Simple' language to Swift, behave like a compiler

// Expressions

extension Number {
	func toSwift() -> String {
		return String(value)
	}
}

extension Boolean {
	func toSwift() -> String {
		return String(value)
	}
}


extension Variable {
	func toSwift() -> String {
		return name
	}
}

extension Add {
	func toSwift() -> String {
		return "(\(left.toSwift()) + \(right.toSwift()))"
	}	
}

extension Multiply {
	func toSwift() -> String {
		return "(\(left.toSwift()) * \(right.toSwift()))"
	}	
}

extension LessThan {
	func toSwift() -> String {
		return "(\(left.toSwift()) < \(right.toSwift()))"
	}	
}

// Statements

extension DoNothing {
	func toSwift() -> String {
		return ""
	}	
}

extension Assign {
	func toSwift() -> String {
		return "\(name) = \(expression.toSwift())"
	}	
}

extension If {
	func toSwift() -> String {
		return "if \(condition.toSwift()) { \(consequence.toSwift()) } else { \(alternative.toSwift()) }"
	}	
}

extension Sequence {
	func toSwift() -> String {
		return "\(first.toSwift());\(second.toSwift())"
	}	
}

extension While {
	func toSwift() -> String {
		return "while \(condition.toSwift()) { \(body.toSwift()) }"
	}		
}
