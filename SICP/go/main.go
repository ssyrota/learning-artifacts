package main

import "fmt"

func main() {
	// expressionsEvaluation()
	// a:= if true { 1 } else { 2 }
	conditionalsEvaluation()
	pascalTriangle(10)
}

func conditionalsEvaluation() {
	a := false && (func() bool {
		fmt.Println("evaluating function in and")
		return true
	}())
	b := true || (func() bool {
		fmt.Println("evaluating function in or")
		return false
	}())
	fmt.Println(a)
	fmt.Println(b)
}

func expressionsEvaluation() {
	fmt.Println(ifElse(true, square(2), square(3)))
}

func square(x int) int {
	fmt.Println("squaring x ", x)
	return x * x
}

func ifElse[T any](cond bool, a, b T) T {
	if cond {
		return a
	}
	return b
}
