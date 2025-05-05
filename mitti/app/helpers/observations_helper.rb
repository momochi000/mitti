module ObservationsHelper
  # Prints out an observation's content to a nice html format
  def observation_content_helper(observation)
    content = JSON.parse(observation.content)
    tag.div object_helper(content), class: 'observation_content_wrap'
  end

  # Prints out an arbitrary object into html for easier reading
  def object_helper(content)
    if content.is_a? Hash
      tag.ul do
        safe_join(content.map do |k,v|
          tag.li do
            tag.span(k) + object_helper(v)
          end
        end)
      end
    elsif content.is_a? Array
      tag.ul do
        safe_join(content.map do |item|
          tag.li object_helper(item)
        end)
      end
    else
      content.to_s
    end
  end
end
