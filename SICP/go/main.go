package main

import "fmt"

func main() {
	// expressionsEvaluation()
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
