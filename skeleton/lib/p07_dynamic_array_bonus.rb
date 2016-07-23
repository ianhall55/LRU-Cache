require 'byebug'

class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    byebug
    return nil if i > @count-1 || @count + i < 0
    if i < 0
      return @store[@count + i]
    else
      @store[i]
    end

  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count >= capacity
    self[@count] = val
    @count += 1
  end

  def unshift(val)

    @count.downto(1).each do |index|
      # byebug
      self[index] = self[index-1]
    end
    self[0] = val
    @count +=1


  end

  def pop
    return nil if count < 1
    val = self[@count-1]
    self[@count-1] = nil
    @count -= 1
    val
  end

  def shift

    val = self[0]
    0.upto(@count).each do |index|
      # byebug
      self[index] = self[index+1]
    end

    @count -=1
    val
  end

  def first
    self[0]
  end

  def last
    self[@count-1]
  end

  def each(&prc)
    (0...@count).each do |el|
      prc.call(self[el])
    end

  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
    (0...@count).each do |idx|
      return false unless self[idx] == other[idx]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_arr = StaticArray.new(@count*2)
    values = @store
    @store = new_arr
    values_count = values.length
    (0...values_count).each do |idx|
      @store[idx] = values[idx]
      # values_count -= 1
    end

  end
  #class end
end
