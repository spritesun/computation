func BigStepSemanticTest() {
	print(">> BigStepSemanticTest")
	print(Add(Multiply(Number(23), Number(32)), Number(73)).evaluate([:]))
	print(Variable("x").evaluate(["x": Number(3)]))
	print(LessThan(Add(Variable("x"), Number(2)), Variable("y")).evaluate(["x": Number(2), "y": Number(5)]))
}

