package main

import (
	"runtime"
	"time"
)

func main() {
	runtime.GOMAXPROCS(1)
	print("hello from main\n")
	go func() {
		print("hello from the first routine\n")
	}()
	go func() {
		print("hello from the second routine, I'm in the direct switch, so actually, I will run first\n")
	}()
	time.Sleep(time.Second)
}
