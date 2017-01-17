
      # Two little demos:

      # Encoding ints, decoding them back:
      num = 125
      (num..(num+10)).each do |i|
        print i, " ", bijective_encode(i), " ", bijective_decode(bijective_encode(i)), "\n"
      end

      # Example use 
      # puts bijective_decode("e9a")

