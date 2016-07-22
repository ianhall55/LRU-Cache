require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num - 1] = true

  end

  def remove(num)
    validate!(num)
    @store[num - 1] = false
  end

  def include?(num)
    validate!(num)
    @store[num-1] == true
  end

  private

  def is_valid?(num)
    num <= @max && num > 0
  end

  def validate!(num)

    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= num_buckets
    @count +=1
    self[num] << num
  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # byebug
    new_arr = Array.new(num_buckets*2) {Array.new}
    values = @store.flatten
    @store = new_arr
    @count = 0
    values.each {|val| insert(val)}

  end
end
