class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_val = 0

    self.each_with_index do |el,i|
      hash_val = hash_val ^ (el.hash+i)
    end
    hash_val
  end
end

class String
  def hash
    hash_val = 0
    self.split("").each_with_index do |s, i|
      hash_val += (s.ord)*i
    end
    hash_val
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_val = 0
    arr = self.values.concat(self.keys)
    arr.each do |el|
      hashed = el.to_s.hash if el.is_a?(Symbol)
      hashed = el.hash
      hash_val = hashed ^ hash_val
    end
    hash_val
  end
end
