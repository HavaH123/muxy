package main

import (
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"

	"github.com/havah123/muxy/command"
	_ "github.com/havah123/muxy/middleware"
	_ "github.com/havah123/muxy/protocol"
	_ "github.com/havah123/muxy/symptom"
	"github.com/mitchellh/cli"
)

func main() {
	os.Exit(realMain())
}

func realMain() int {
	rand.Seed(time.Now().Unix())
	cli := cli.NewCLI(strings.ToLower(ApplicationName), Version)
	cli.Args = os.Args[1:]
	cli.Commands = command.Commands

	exitStatus, err := cli.Run()
	if err != nil {
		fmt.Fprintln(os.Stderr, err.Error())
	}

	return exitStatus
}
