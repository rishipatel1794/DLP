class RecursiveDescentParser:
    def __init__(self, input_string):
        self.input = input_string
        self.pos = 0

    def parse(self):
        if self.S() and self.pos == len(self.input):
            return True
        return False

    def S(self):
        if self.pos < len(self.input) and self.input[self.pos] == 'a':
            self.pos += 1
            return True
        elif self.pos < len(self.input) and self.input[self.pos] == '(':
            self.pos += 1
            if self.L() and self.pos < len(self.input) and self.input[self.pos] == ')':
                self.pos += 1
                return True
        return False

    def L(self):
        if self.S():
            return self.L_prime()
        return False

    def L_prime(self):
        if self.pos < len(self.input) and self.input[self.pos] == ',':
            self.pos += 1
            if self.S():
                return self.L_prime()
            return False
        return True

# Test cases
st = input("Enter the String:")

parser = RecursiveDescentParser(st)
print(parser.parse())
