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

check_set :: proc(section: string) -> bool {
    section_limits : []struct{num_cubes: int, color: string} = {{12, "red"}, {13, "green"}, {14, "blue"}}
    valid := true
    if strings.contains(section, ";") {
        sub_set := strings.split_after(section, ";")
        for set in sub_set {
            cleared_set, _ := strings.remove(set, " ", 1)
            num_cubes, _ := strconv.parse_int(cleared_set[0:strings.index(cleared_set, " ")])
            color := cleared_set[strings.index(cleared_set, " ")+1:]
            fmt.println(cleared_set)
            for tuple in section_limits {
                if strings.contains(color, tuple.color) {
                    if num_cubes > tuple.num_cubes {
                        valid = false
                    }
                }
            }
        }
    } else {
        cleared_section, _ := strings.remove(section, " ", 1)
        num_cubes, _ := strconv.parse_int(cleared_section[0:strings.index(cleared_section, " ")])
        color := cleared_section[strings.index(cleared_section, " ")+1:]
        fmt.println(cleared_section)
        for tuple in section_limits {
            if strings.contains(color, tuple.color) {
                if num_cubes > tuple.num_cubes {
                    valid = false
                }
            }
        }
    }
    return valid
}

check_line :: proc(s: string) -> bool {
    sections, _ := strings.split_after(s, ",")
    valid := false
    for section in sections {
        if !check_set(section) {
            return false
        }
        valid = true
    }
    return valid
}

parse_line :: proc(s: string) -> int {
    game_id := 0
    valid := check_line(s[strings.index(s, ":")+1:])
    if valid {
        game_id, _ = strconv.parse_int(s[5:strings.index(s, ":")])
    } else {
        game_id = 0
    }
    fmt.println(game_id)
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