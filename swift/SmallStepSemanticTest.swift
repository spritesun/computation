func SmallStepSemanticTest() {
	print(">> SmallStepSemanticTest")
	var statement : Statement
	var env : [String: Expression]
	var machine : Machine

	statement = While(LessThan(Variable("x"), Number(5)), Assign("x", Multiply(Variable("x"), Number(3))))
	env = ["x": Number(1)]
	machine = Machine(statement, env)
	machine.run()	
}

