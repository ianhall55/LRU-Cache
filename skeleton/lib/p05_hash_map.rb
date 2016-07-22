require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val=true)
    resize! if @count >= num_buckets
    if bucket(key).include?(key)
      bucket(key).remove(key)
    end

    bucket(key).insert(key,val)
    @count += 1

  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)

    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end


  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_list = Array.new(num_buckets*2) {LinkedList.new}
    values = []

    each do |k,v|
      values << [k,v]
    end
    @count = 0
    @store = new_list
    values.each do |sets|
      set(sets[0], sets[1])
    end

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    bucket_num = key.hash % num_buckets
    bucket = @store[bucket_num]
  end
end
