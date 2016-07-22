require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    resize! if @count >= num_buckets
    @count +=1

    self[el] << el
  end

  def remove(el)
    self[el].delete(el) if self[el].include?(el)
  end

  def include?(el)
    self[el].include?(el)
  end

  private

  def [](el)
    # optional but useful; return the bucket corresponding to `el`
    @store[el.hash % num_buckets]
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
