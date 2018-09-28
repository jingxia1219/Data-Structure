require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) {[]}
    @count = 0
  end

  def insert(key)
    self[key.hash] << key 
    @count += 1
    resize! if num_buckets == @count
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end 
  end

  private

  def [](num)
    @store[num% @store.length]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets*2) {[]}
    @store.flatten.each do |el|
      new_arr[el.hash% new_arr.length] << el 
    end 
    @store = new_arr
  end
end
