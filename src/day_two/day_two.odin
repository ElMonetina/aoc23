package day_two

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

load_input :: proc (path: string) -> string {
    input, ok := os.read_entire_file(path)

    if !ok {
        fmt.eprintln("Failed to read file")
        os.exit(int(os.ERROR_FILE_NOT_FOUND)) 
    }
    return string(input)
}

// Returns []int (number of cubes) and []string (color of cubes)
line_tokenizer :: proc(line: string) -> ([]int, []string) {
    s := line
    n_arr : [dynamic]int
    c_arr : [dynamic]string
    defer delete(n_arr)
    defer delete(c_arr)
    tokens := strings.split_after(s, " ")
    for &token in tokens {
        token, _ = strings.remove(token, " ", 1)
        token, _ = strings.remove(token, ",", 1)
        token, _ = strings.remove(token, ";", 1)
    }
    for i in 0..<len(tokens) {
        if i%2 == 0 {
            n, _ := strconv.parse_int(tokens[i])
            append(&n_arr, n)
        } else {
            c := tokens[i]
            append(&c_arr, c)
        }
    }
    return n_arr[:], c_arr[:]
}

// returns true if the pairs are all valid, false otherwise
check_validity :: proc(n_arr: []int, c_arr: []string) -> bool {
    valid := true
    for i in 0..<len(n_arr) {
        switch {
        case c_arr[i] == "red" :
            if n_arr[i] > 12 {
                valid = false
            }
        case c_arr[i] == "green":
            if n_arr[i] > 13 {
                valid = false
            }
        case c_arr[i] == "blue":
            if n_arr[i] > 14 {
                valid = false
            }
        }
    }
    return valid
}

// parses the line
parse_line :: proc(line: string, i: int) -> int {
    num_cubes, cubes_color := line_tokenizer(line[strings.index(line, ":")+2:])
    valid := check_validity(num_cubes, cubes_color)
    id := 0
    if valid {
        id = i+1
    }
    return id
}

part_one :: proc(input: string) -> int {
    s := input
    lines := strings.count(s, "\n") + 1 // +1 because the last line doesn't end with newline
    sum := 0
    for i in 0..<lines {
        line, _ := strings.split_lines_iterator(&s)
        sum += parse_line(line, i)
    }
    return sum
}

print_solution :: proc(part, input: string, solution_proc: proc(string) -> int) {
    solution := solution_proc(input)
    fmt.println(part, solution)
}

run :: proc() {
    input := load_input("src/day_two/input.txt")
    print_solution("Part one:", input, part_one)
}