class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = ""
    self.each do |el|
      result << el.object_id.to_s
    end
    result.to_i
  end 
end

class String
  def hash
    result = ''
    letters = ("a".."z").to_a 
     self.chars do |el|
      result << letters.find_index(el).to_s
    end 
    result.to_i
  end
end


class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    
   self.each do |h,v|
   subresult = ''
    subresult << h.hash.to_s
    subresult << v.hash.to_s
    result += subresult.to_i
   end 
   result
  end
end
