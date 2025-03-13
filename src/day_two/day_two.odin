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

check_line :: proc(s: string) -> bool {
    sections, _ := strings.split_after(s, ",")
    invalid := false
    max_sets : []struct{num_cubes: int, color: string} = {{12, "red"}, {13, "green"}, {14, "blue"}}
    for section in sections {
        color := ""
        if strings.contains(section, ";") {
            sub_section, _ := strings.split_after(section, ";")
            num_cubes, _ := strconv.parse_int(sub_section[:strings.index(sub_section, " ")])            
            for set in max_sets{
                if strings.contains(sub_section, set.color) {
                    color = set.color
                }
            }
        }
        num_cubes, _ := strconv.parse_int(section[:strings.index(section, " ")])
        for set in max_sets {
            if strings.contains(section, set.color) {
                color = set.color
            }
            if num_cubes > set.num_cubes {
                invalid = true
                return invalid
            }
            invalid = false
        }

    }
    return invalid
}

parse_line :: proc(s: string) -> int {
    game_id := 0
    invalid := check_line(s[:strings.index(s, ":")+1])
    if !invalid {
        game_id, _ = strconv.parse_int(s[strings.index(s, " ")+1:strings.index(s, ":")+1])
    } else {
        game_id = 0
    }
    return game_id
}

part_one :: proc(input: string) -> int {
    s := input
    lines := strings.count(s, "\n") + 1
    
    sum := 0

    for i in 0..<lines {
        line, _ := strings.split_lines_iterator(&s)
        sum += parse_line(line)
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