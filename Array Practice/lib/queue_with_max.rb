# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    self.store = RingBuffer.new
    @max = nil 
  end 

  def enqueue(val)
    self.store.unshift(val)
    @max = val if @max.nil? || @max < val  
  end

  def dequeue
    val = self.store.pop 
    if val == @max 
      if self.store.length == 0 
        @max = nil 
      else 
        @max = self.store[0]
        (1...self.store.length).each do |i|
          @max = self.store[i] if @max <  self.store[i]
        end 
        
      end 
    end 

  end

  def max
    @max 
  end

  def length
    self.store.length
  end

end
