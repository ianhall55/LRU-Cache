require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    index = 0
    each_with_index do |link, j|
      return link if i == j || i ==index
      index +=1
    end
    nil
  end

  def each_with_index(&prc)
    node = @head.next
    until node == @tail

      prc.call(node, node.key)
      node = node.next
    end
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    return nil unless include?(key)
    self[key].val

  end

  def include?(key)
    node = @head
    until node == @tail
      return true if node.key == key
      node = node.next
    end
    false
  end

  def insert(key, val)
    new_node = nil
    if include?(key)
      self[key].val = val
      # new_node = self[key]
    else
      new_node = Link.new(key, val)
      new_node.prev, new_node.next = last, @tail
      last.next = new_node
      @tail.prev = last.next
    end
    new_node
  end

  def remove(key)
    if include?(key)
      to_remove = self[key]
      to_remove.prev.next = to_remove.next
      to_remove.next.prev = to_remove.prev
    else
      raise "not in linked list"
    end
  end

  def each(&prc)
    node = @head.next

    until node == @tail
      prc.call(node)
      node = node.next
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
