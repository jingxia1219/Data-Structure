require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
       self.store, self.capacity, self.length = StaticArray.new(0), 8, 0
  end

  # O(1)
  # getter
  def [](index)
    # raise "index out of bounds" if @length < 1|| index >= @length
    check_index(index)
    self.store[index]
  end

  # O(1)
  # setter
  def []=(index, value)
    check_index(index)
    self.store[index] = value 
  end

  # O(1)
  def pop
    raise 'index out of bounds' if self.length == 0 

    val, self[length - 1 ] = self[length - 1 ], nil
    self.length -= 1 
    val

  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if self.length == self.capacity
    self.length += 1 
    self[length - 1] = val 
    nil 
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if (length == 0)

    val = self.store[0]
    self.store = self.store[1..-1]
    self.length -=1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    new_arr = [val]
    resize! if self.capacity == @length 
    self.length += 1 
    i = 0 
    while i < self.length - 1
      new_arr << self.store[i]
      i+=1
    end 
    self.store = new_arr
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length || index < 0
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity *=2 
    new_store = StaticArray.new(capacity)
      self.length.times { |i| new_store[i] = self[i] } 
    self.store = new_store
  end
end
