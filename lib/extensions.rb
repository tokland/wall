module Enumerable
  def map_compact(&block)
    self.map(&block).compact
  end
  
  def map_detect(value_for_no_match = nil)
    self.each do |member|
      if result = yield(member)
        return result
      end
    end    
    value_for_no_match
  end
  
  def mash
    self.inject({}) do |hash, item|
      key, value = block_given? ? yield(item) : item
      hash.merge(key => value) 
    end      
  end    
end
