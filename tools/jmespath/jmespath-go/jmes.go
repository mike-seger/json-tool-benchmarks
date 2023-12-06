package main

import (
    "bufio"
    "encoding/json"
    "fmt"
    "github.com/jmespath-community/go-jmespath"
    "os"
    "strconv"
    "strings"
    "time"
)

func main() {
    if len(os.Args) < 2 {
        fmt.Println("Usage: go run main.go '<jmespath-query>' [n invocations] ['json-string']")
        os.Exit(1)
    }

    query := os.Args[1]
    var jsonInput string
    var n int
    var err error

    if len(os.Args) == 3 {
        n, err = strconv.Atoi(os.Args[2])
        if err != nil {
            fmt.Println("Invalid number of invocations:", err)
            os.Exit(1)
        }
        jsonInput = readJsonFromStdin()
    } else if len(os.Args) > 3 {
        n, err = strconv.Atoi(os.Args[2])
        if err != nil {
            fmt.Println("Invalid number of invocations:", err)
            os.Exit(1)
        }
        jsonInput = os.Args[3]
    } else {
        jsonInput = readJsonFromStdin()
    }

    if n > 0 {
        fmt.Println("Input JSON:", jsonInput[:min(len(jsonInput), 1024)])
        fmt.Println("Query:", query)
        fmt.Println("n:", n)
    }

    // Parse JSON data to interface{}
    var data interface{}
    json.Unmarshal([]byte(jsonInput), &data)

    // Compile JMESPath query
    expression, err := jmespath.Compile(query)
    if err != nil {
        fmt.Println("Error compiling JMESPath query:", err)
        os.Exit(1)
    }

    // Execute query multiple times and measure time
    startTime := time.Now()
    for i := 0; i < n; i++ {
        expression.Search(data)
    }
    elapsed := time.Since(startTime)

    // Execute query and print result
    result, err := expression.Search(data)
    if err != nil {
        fmt.Println("Error executing JMESPath query:", err)
        os.Exit(1)
    }

    fmt.Println("Result:", result)

    if n > 0 {
        fmt.Printf("%.4f\n", elapsed.Seconds())
    }
}

func readJsonFromStdin() string {
    scanner := bufio.NewScanner(os.Stdin)
    var lines []string
    for scanner.Scan() {
        lines = append(lines, scanner.Text())
    }
    return strings.Join(lines, "\n")
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
