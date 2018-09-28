class MaxIntSet
  def initialize(max)
    @max = max 
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" if num >= @max || num < 0
    @store[num] = true 
  end

  def remove(num)
    @store[num] = false 
  end

  def include?(num)
    @store[num] == true 
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].delete(num) 
  end

  def include?(num)
     self[ num ].include?(num)
  end

  private

  def [](num)
    length = @store.length
    @store[num % length]
  end

  def num_buckets
     length = @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [] }
    @count = 0 
  end

  def insert(num)
    self[num] << num 
    @count += 1
    resize! if num_buckets == @count 
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -=1 
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!   
    new_arr = Array.new(num_buckets*2) {[]}
    @store.flatten.each do |el|
      new_arr[el% new_arr.length ] << el
    end 
    @store = new_arr
  end 

end
