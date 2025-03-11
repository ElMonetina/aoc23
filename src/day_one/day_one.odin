package day_one

import "core:os"
import "core:fmt"
import "core:strings"

load_input :: proc(path: string) -> string {
    input, ok := os.read_entire_file(path)
    if !ok {
        fmt.eprintln("Input file could not be read")
        os.exit(int(os.ERROR_FILE_NOT_FOUND))        
    }
    return string(input)
}

print_solution :: proc(part, input: string, solution_proc: proc(string) -> int) {
    solution := solution_proc(input)
    fmt.println(part, solution)
}

parse_first :: proc(s: string) -> (int, int) {
    first := 0
    first_pos := len(s)
    tokens := make(map[string]int)
    defer delete(tokens)
    
    // Map initialization
    tokens["1"]     = 1
    tokens["one"]   = 1
    tokens["2"]     = 2
    tokens["two"]   = 2
    tokens["3"]     = 3
    tokens["three"] = 3
    tokens["4"]     = 4
    tokens["four"]  = 4
    tokens["5"]     = 5
    tokens["five"]  = 5
    tokens["6"]     = 6
    tokens["six"]   = 6
    tokens["7"]     = 7
    tokens["seven"] = 7
    tokens["8"]     = 8
    tokens["eight"] = 8
    tokens["9"]     = 9
    tokens["nine"]  = 9
    
    for token in tokens {
        temp_pos := strings.index(s, token)
        temp := tokens[token]
        if temp_pos < first_pos {
            first = temp
            first_pos = temp_pos
        }
    }
    return first, first_pos
}

parse_last :: proc(s: string) -> (int, int) {
    last := 0
    last_pos := 0
    tokens := make(map[string]int)
    defer delete(tokens)
    
    // Map initialization
    tokens["1"]     = 1
    tokens["one"]   = 1
    tokens["2"]     = 2
    tokens["two"]   = 2
    tokens["3"]     = 3
    tokens["three"] = 3
    tokens["4"]     = 4
    tokens["four"]  = 4
    tokens["5"]     = 5
    tokens["five"]  = 5
    tokens["6"]     = 6
    tokens["six"]   = 6
    tokens["7"]     = 7
    tokens["seven"] = 7
    tokens["8"]     = 8
    tokens["eight"] = 8
    tokens["9"]     = 9
    tokens["nine"]  = 9
    
    for token in tokens {
        temp_pos := strings.index(s, token)
        temp := tokens[token]
        if temp_pos >= last_pos {
            last = temp
            last_pos = last_pos
        }
    }
    return last, last_pos
}

parse_line :: proc(s: string) -> int {
    first, first_pos := parse_first(s)
    last, last_pos := parse_last(s)
    
    value := 0
    
    if first_pos == last_pos {
        value = first
    } else {
        value = first * 10 + last
    }
    return value
}

part_two :: proc(input: string) -> int {
    s := input
    lines := strings.count(s, "\n") + 1
    first, last := 0, 0
    
    sum := 0
    
    for i in 0..<lines {
        line, _ := strings.split_lines_iterator(&s)
        sum += parse_line(line)
    }
    return sum
}

run :: proc() {
    input := load_input("src/day_one/input.txt")
    print_solution("Day two:", input, part_two)
}