package main

import "fmt"

func pascalTriangle(n int) int {
	res := make([][]int, n)
	first := []int{1}
	res[0] = first
	for i := 1; i < n; i++ {
		res[i] = nextGenPascal(res[i-1])
		fmt.Printf("\n%+v", res[i])
	}

	return 0
}

func nextGenPascal(l []int) []int {
	next_gen := make([]int, len(l)+1)
	for i := 0; i <= len(l); i++ {
		var num int
		if i == 0 || i == len(l) {
			num = 1
		} else {
			num = l[i] + l[i-1]
		}
		next_gen[i] = num
	}
	return next_gen
}
