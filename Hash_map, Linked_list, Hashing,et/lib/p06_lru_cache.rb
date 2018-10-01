require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @link_list = LinkedList.new
    @map = HashMap.new(max)
    @prc = prc
    @max = max 
  end

  def count
   @map.count  #counts how many nodes in the hash map
  end

  def get(key)
    if @link_list.include?(key)
      update_node!(key)
    else 
      insert_new!(key)
    end 
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def insert_new!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    eject! if count == @max
      @map.set(key,val)
      @link_list.append(key, val )
      val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @link_list.remove(node)
      @link_list.append(node.key, node.val)
  end


  def eject!
    first_item = @link_list.first
    @link_list.remove(first_item.key)
    @map.delete(first_item.key)
  end
end
