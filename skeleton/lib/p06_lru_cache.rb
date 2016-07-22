require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.count > @max
      eject!
    end

    if @map[key].nil?
      calc!(key)
    else
      update_link!(@map[key])
    end

    @map[key].val

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    link = @store.insert(key,value)
    @map.set(key,link)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev
    @store.insert(link.key,link.val)
  end

  def eject!
    first_key = @store.first.key
    @store.remove(first_key)
    @map.delete(first_key)
  end

end
