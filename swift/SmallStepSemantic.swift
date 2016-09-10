// Computation experiment
// Small-step semantic interpreter in swift

// expressions, immutable for environment

struct Number : Expression {
    let value: Double
    
	init(_ value : Double) {
		self.value = value
	}
	
    var description: String {
        return "(\(value))"
    }
    
    var isReducible: Bool {
        return false
    }    	
}

struct Add : Expression {
    let left: Expression
    let right: Expression
    
	init(_ left : Expression, _ right : Expression) {
		self.left = left
		self.right = right
	}
	
    var description: String {
        return "(\(left) + \(right))"
    }
    
    var isReducible: Bool {
        return true
    }
    
    func reduce(env: [String: Expression]) -> Expression {
        if left.isReducible {
            return Add(left.reduce(env), right)
        } else if right.isReducible {
            return Add(left, right.reduce(env))
        } else if let leftNumber = left as? Number, rightNumber = right as? Number {
            return Number(leftNumber.value + rightNumber.value)
        }
        fatalError("Add reduce failed.")
    }
}

struct Multiply : Expression {
    let left: Expression
    let right: Expression
    
	init(_ left : Expression, _ right : Expression) {
		self.left = left
		self.right = right
	}
	
    var description: String {
        return "(\(left) * \(right))"
    }
    
    var isReducible: Bool {
        return true
    }
    
    func reduce(env: [String: Expression]) -> Expression {
        if left.isReducible {
            return Multiply(left.reduce(env), right)
        } else if right.isReducible {
            return Multiply(left, right.reduce(env))
        } else if let leftNumber = left as? Number, rightNumber = right as? Number {
            return Number(leftNumber.value * rightNumber.value)
        }
        fatalError("Multiply reduce failed.")
    }
}

struct Boolean : Expression {
    let value: Bool
    
	init(_ value : Bool) {
		self.value = value
	}
	
    var description: String {
        return "(\(value))"
    }
    
    var isReducible: Bool {
        return false
    }
}

struct LessThan : Expression {
    let left: Expression
    let right: Expression
    
	init(_ left : Expression, _ right : Expression) {
		self.left = left
		self.right = right
	}
	
    var description: String {
        return "(\(left) < \(right))"
    }
    
    var isReducible: Bool {
        return true
    }
    
    func reduce(env: [String: Expression]) -> Expression {
        if left.isReducible {
            return LessThan(left.reduce(env), right)
        } else if right.isReducible {
            return LessThan(left, right.reduce(env))
        } else if let leftNumber = left as? Number, rightNumber = right as? Number {
            return Boolean(leftNumber.value < rightNumber.value)
        }
        fatalError("LessThan reduce failed.")
    }
}

struct Variable : Expression {
    let name : String
    
	init(_ name : String) {
		self.name = name
	}
	
    var description: String {
        return "(\(name))"
    }
    
    var isReducible: Bool { return true }
    
    func reduce(env: [String: Expression]) -> Expression {
        return env[name]!
    }
}

// statements, mutating environment

struct DoNothing: Statement {
	var description: String {
		return "do-nothing"
	}
	
	var isReducible : Bool { return false }		
}

struct Assign : Statement {
    let name : String
    let expression : Expression
    
	init(_ name : String, _ expression: Expression) {
		self.name = name
		self.expression = expression
	}
		
    var description: String {
        return "\(name) = \(expression)"
    }
    
    var isReducible: Bool { return true }
    
    func reduce(env: [String : Expression]) -> (statement: Statement, env: [String: Expression]) {
        if expression.isReducible {
        	return (Assign(name, expression.reduce(env)), env)
        } else {
			var new_env = env
			new_env[name] = expression
        	return (DoNothing(), new_env)
        }
    }
}

struct If : Statement {
	let condition : Expression
	let consequence, alternative : Statement
	
	init(_ condition : Expression, _ consequence: Statement, _ alternative : Statement) {
		self.condition = condition
		self.consequence = consequence
		self.alternative = alternative
	}
	
	var description: String {
		return "if (\(condition)) { \(consequence) } else { \(alternative) }"
	}
	
	var isReducible: Bool { return true }

	func reduce(env: [String: Expression]) -> (statement: Statement, env: [String: Expression]) {
        if condition.isReducible {
			return (If(condition.reduce(env), consequence, alternative), env)
		} else if let conditionBool = condition as? Boolean {
			if conditionBool.value {
				return (consequence, env)
			} else {
				return (alternative, env)
			}
		}
		fatalError("If reduce failed.")
	}
}

struct Sequence : Statement {
	let first, second : Statement
	
	init(_ first : Statement, _ second : Statement) {
		self.first = first
		self.second = second
	}
	
	var description : String {
		return "\(first); \(second)"
	}
	
	var isReducible: Bool { return true }
	
	func reduce(env: [String: Expression]) -> (statement: Statement, env: [String: Expression]) {
		if first is DoNothing {
			return (second, env)
		} else {
			let (reducedFirst, reducedEnv) = first.reduce(env)
			return (Sequence(reducedFirst, second), reducedEnv)
		}
	}
}

struct While : Statement {
	let condition : Expression
	let body : Statement
	
	init(_ condition : Expression, _ body : Statement) {
		self.condition = condition
		self.body = body
	}
	
	var description : String {
		return "while (\(condition)) { \(body) }"
	}
	
	var isReducible: Bool { return true }
	
	func reduce(env: [String: Expression]) -> (statement: Statement, env: [String: Expression]) {
		// very interesting explain for <while> statement
		// translate to <if> statement with a <while> consequence, make it iterative
		return (If(condition, Sequence(body, self), DoNothing()), env)
	}
}

// finite-status machine

struct Machine {
    var statement: Statement
    var env: [String: Expression]

	init(_ statement : Statement, _ env: [String: Expression]) {
		self.statement = statement
		self.env = env
	}

    mutating func step() {
        (statement, env) = statement.reduce(env)
    }
    
    mutating func run() {
		print("Machine start:")
        while statement.isReducible {
            print("\(statement), \(env)")
            step()
        }
        print("\(statement), \(env)")
    }
}
