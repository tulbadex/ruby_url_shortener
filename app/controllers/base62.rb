class Base62
    ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze
    BASE = ALPHABET.length
    
    def self.encode(number)
        return ALPHABET[0] if number.zero? || number.nil?
        result = ""

        while number > 0 do
            index = number % BASE
            result.prepend(ALPHABET[index])
            number /= BASE
        end

        result
    end

    def self.decode(string)
        result = 0

        # string.each_char do |char|
        #     result = result * BASE + ALPHABET.index(char)
        # end

        string.reverse.each_char.with_index do |char, index|
            power = BASE**index
            index = ALPHABET.index(char)
            result += index * power
        end

        result
    end
end
