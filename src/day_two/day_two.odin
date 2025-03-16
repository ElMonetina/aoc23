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

print_solution :: proc(part, input: string, solution_proc: proc(string) -> int) {
    solution := solution_proc(input)
    fmt.println(part, solution)
}

// Returns []int (number of cubes) and []string (color of cubes)
line_tokenizer :: proc(line: string) -> ([]int, []string) {
    s := line
    numbers_dyn : [dynamic]int
    colors_dyn : [dynamic]string
    defer {
        clear(&colors_dyn)
        clear(&numbers_dyn)
    }
    tokens := strings.split_after(s, " ")
    for &token in tokens {
        token, _ = strings.remove(token, " ", 1)
        token, _ = strings.remove(token, ",", 1)
        token, _ = strings.remove(token, ";", 1)
    }
    for i in 0..<len(tokens) {
        if i%2 == 0 {
            n, _ := strconv.parse_int(tokens[i])
            append(&numbers_dyn, n)
        } else {
            c := tokens[i]
            append(&colors_dyn, c)
        }
    }
    numbers, colors := numbers_dyn[:],  colors_dyn[:]
    return numbers, colors
}

// returns true if the pairs are all valid, false otherwise
check_validity :: proc(numbers: []int, colors: []string) -> bool {
    valid := true
    for i in 0..<len(numbers) {
        switch {
        case colors[i] == "red" :
            if numbers[i] > 12 {
                valid = false
            }
        case colors[i] == "green":
            if numbers[i] > 13 {
                valid = false
            }
        case colors[i] == "blue":
            if numbers[i] > 14 {
                valid = false
            }
        }
    }
    return valid
}

part_one :: proc(input: string) -> int {
    s := input
    lines := strings.count(s, "\n") + 1 // +1 because the last line doesn't end with newline
    sum := 0
    for i in 0..<lines {
        line, _ := strings.split_lines_iterator(&s)
        numbers, colors := line_tokenizer(line[strings.index(line, ":")+2:])
        valid := check_validity(numbers, colors)
        if valid {
            sum += i+1
        }
    }
    return sum
}

required_cubes :: proc(numbers: []int, colors: []string) -> ([]int, []int, []int) {
    reds_dyn : [dynamic]int
    greens_dyn : [dynamic]int
    blues_dyn : [dynamic]int
    defer {
        clear(&blues_dyn)
        clear(&greens_dyn)
        clear(&reds_dyn)
    }
    for i in 0..<len(colors) {
        switch {
        case colors[i] == "red":
            append(&reds_dyn, numbers[i])
        case colors[i] == "green":
            append(&greens_dyn, numbers[i])
        case colors[i] == "blue":
            append(&blues_dyn, numbers[i])
        }
    }
    reds, greens, blues := reds_dyn[:], greens_dyn[:], blues_dyn[:]
    return reds, greens, blues
}

find_max_int :: proc(numbers: []int) -> int {
    max := 0
    for n in numbers {
        if n > max {
            max = n
        }
    }
    return max
}

part_two :: proc(input: string) -> int {
    s := input
    lines := strings.count(s, "\n") + 1
    sum := 0
    for i in 0..<lines {
        line, _ := strings.split_lines_iterator(&s)
        numbers, colors := line_tokenizer(line[strings.index(line, ":")+2:])
        red_cubes, green_cubes, blue_cubes := required_cubes(numbers, colors)
        max_red := find_max_int(red_cubes)
        max_green := find_max_int(green_cubes)
        max_blue := find_max_int(blue_cubes)
        sum += max_red * max_green * max_blue 
    }
    return sum
}

run :: proc() {
    input := load_input("src/day_two/input.txt")
    print_solution("Part one:", input, part_one)
    print_solution("Part two:", input, part_two)
}