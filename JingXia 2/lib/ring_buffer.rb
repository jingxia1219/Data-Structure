require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.capacity = 8 
    self.start_idx = 0 
    self.length = 0
    self.store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    check_index(index)
    self.store[(start_idx+index)%self.capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    self.store[(start_idx+index)%self.capacity] = val 
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0 
    val = self.store[(self.start_idx + self.length - 1) % self.capacity ]
    self.length -= 1 
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if self.length == self.capacity
    self.store[(self.start_idx+self.length)%self.capacity] = val 
    self.length += 1 
    val 
  end

  # O(1)
  def shift
    raise "index out of bounds" if self.length == 0 
    val = self.store[self.start_idx]
    self.start_idx += 1 
    self.length -=1 
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if self.length == self.capacity
    self.start_idx -= 1 
    self.store[start_idx] = val 
    self.length += 1 
    val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= self.length || index < 0 
  end

  def resize!
    new_arr = StaticArray.new(self.capacity*2)
    self.length.times { |i| new_arr[i] = self[i]}
    self.store = new_arr
    self.capacity *=2  
    self.start_idx = 0
  end
end
