def show tag='*', target=page
  $logger.info("showing #{tag} for #{target.inspect}")
  elements = target.all(tag)
  $logger.info("#{elements.size} suboordinates")
  elements.each do |subordinate|
    show_me subordinate
  end
end

def dump target=page
  $logger.info("dumping #{target}")
  show '*', target
end

def show_me target
  $logger.info("#{target.inspect}" +
                   ":id=#{target['id']}" +
                   ":class=#{target['class']}" +
                   ":name=#{target['name']}" +
                   ":for=#{target['for']}" +
                   ":value=#{target.value}" +
                   ":text=#{target.text}")
end