class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key, @val = key, val 
    @next, @prev = nil, nil 
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next 
    @next.prev = @prev 
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail, :next, :prev 
  def initialize
    @head,@tail = Node.new, Node.new 
    @head.next = @tail 
    @tail.prev = @head 
  end

  def [](i)
    current = @head.next
    until i == 0 || current.key.nil? 
      current = current.next 
      i -= 1
    end 
    current.key ? current : nil
     
  end

  def first
    return nil if empty?
    @head.next 
  end

  def last
    return nil if empty?
    @tail.prev 
  end

  def empty?
    return true if @head.next == @tail 
    false 
  end

  # O(n)
  def get(key)
      return nil if empty? 
      current = first 
      until current.key.nil? 
        return current.val if current.key == key 
        current = current.next 
      end 
      nil
  end

  # O(n)
  def include?(key)
    get(key) ? true : false 
  end

  # O(1)
  def append(key, val)
    new_node = Node.new(key,val)
    if empty? 
      @head.next = new_node
      @tail.prev = new_node
      new_node.next, new_node.prev = @tail, @head 
    else 
      old_last = last 
      @tail.prev = new_node
      new_node.next = @tail
      new_node.prev = old_last
      old_last.next = new_node
    end 
  end

  # O(n)
  def update(key, val)
    return nil unless include?(key)
    current = first 
    until current.key.nil?
      if current.key == key 
        current.val = val  
        return 
      else 
        current = current.next 
      end 
    end 
  end

  # O(n)
  def remove(key)
  return nil unless include?(key)
      current = first 
      until current.key.nil?
        if current.key == key 
          current.remove
          return 
        else 
          current = current.next 
        end 
      end 
  end

  def each
    return nil if empty? 
    current = first 
    until current.key.nil?
      yield current 
      current = current.next
    end 
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
