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
    pos := len(s)
    tokens : []struct{w: string, v: int} = {{"1", 1}, {"one", 1},
                                            {"2", 2}, {"two", 2},
                                            {"3", 3}, {"three", 3},
                                            {"4", 4}, {"four", 4},
                                            {"5", 5}, {"five", 5},
                                            {"6", 6}, {"six", 6},
                                            {"7", 7}, {"seven", 7},
                                            {"8", 8}, {"eight", 8},
                                            {"9", 9}, {"nine", 9}}
    for token in tokens {
        temp_pos := strings.index(s, token.w)
     if temp_pos < pos && temp_pos != -1 {
            first = token.v
            pos = temp_pos
        }
    }
    return first, pos
}
    


parse_last :: proc(s: string) -> (int, int) {
    last := 0
    pos := 0
    tokens : []struct{w: string, v: int} = {{"1", 1}, {"one", 1},
                                            {"2", 2}, {"two", 2},
                                            {"3", 3}, {"three", 3},
                                            {"4", 4}, {"four", 4},
                                            {"5", 5}, {"five", 5},
                                            {"6", 6}, {"six", 6},
                                            {"7", 7}, {"seven", 7},
                                            {"8", 8}, {"eight", 8},
                                            {"9", 9}, {"nine", 9}}
    for token in tokens {
        temp_pos := strings.last_index(s, token.w)
        if temp_pos >= pos && temp_pos != -1 {
            last = token.v
            pos = temp_pos
        } else {
            continue
        }
    }
    return last, pos
}

parse_line :: proc(s: string) -> int {
    first, first_pos := parse_first(s)
    last, last_pos := parse_last(s)
    
    value := first * 10 + last

    fmt.println("First:", first, "at position:", first_pos, "Last:", last, "at position:", last_pos, "Value:", value)
    return value
}

part_two :: proc(input: string) -> int {
    s := input
    lines := strings.count(s, "\n") + 1
    
    sum := 0
    
    for i in 0..<lines {
        line, _ := strings.split_lines_iterator(&s)
        fmt.print("Line:", i + 1, " ")
        sum += parse_line(line)
    }
    return sum
}

run :: proc() {
    input := load_input("src/day_one/input.txt")
    print_solution("Day two:", input, part_two)
}