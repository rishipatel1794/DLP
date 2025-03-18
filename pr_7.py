from collections import defaultdict

grammar = {
    'S': ['ABC', 'ε'],
    'A': ['a', 'ε'],
    'B': ['b', 'ε'],
    'C': ['(S)', 'c'],
    'D': ['AC']
}

first = defaultdict(set)
follow = defaultdict(set)

# Function to calculate FIRST set
def compute_first(symbol):
    if symbol in first and first[symbol]:
        return first[symbol]

    if not symbol.isupper():
        return {symbol}

    for production in grammar[symbol]:
        if production == 'ε':
            first[symbol].add('ε')
            continue

        for char in production:
            char_first = compute_first(char)
            first[symbol].update(char_first - {'ε'})

            if 'ε' not in char_first:
                break
        else:
            first[symbol].add('ε')

    return first[symbol]

# Function to calculate FOLLOW set
def compute_follow(symbol):
    if not follow[symbol] and symbol == 'S':
        follow[symbol].add('$')

    for lhs, productions in grammar.items():
        for production in productions:
            if symbol in production:
                idx = production.index(symbol)

                while idx < len(production) - 1:
                    next_char = production[idx + 1]
                    next_first = compute_first(next_char)
                    follow[symbol].update(next_first - {'ε'})

                    if 'ε' in next_first:
                        idx += 1
                    else:
                        break
                else:
                    if symbol != lhs:
                        follow[symbol].update(compute_follow(lhs))

    return follow[symbol]

# Compute FIRST sets
for non_terminal in grammar:
    compute_first(non_terminal)

# Compute FOLLOW sets
for non_terminal in grammar:
    compute_follow(non_terminal)

# Print FIRST sets
print("FIRST sets:")
for non_terminal in first:
    print(f"{non_terminal}: {first[non_terminal]}")

# Print FOLLOW sets
print("\nFOLLOW sets:")
for non_terminal in follow:
    print(f"{non_terminal}: {follow[non_terminal]}")
