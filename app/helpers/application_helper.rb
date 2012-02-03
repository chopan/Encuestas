module ApplicationHelper
   def flash_messages
    output = ""
    flash.each do |key, value|
      if key == :error
        type = "error"
      elsif key == :notice
        type = "success"
      else
        type = "warning"
      end
      
      output += 
      "<div class='alert-message block-message #{type} fade in' data-alert='alert'>
      <a class='close' href='#'>&times;</a>
      <p>#{value}</p>       
      </div>"
    end
    raw(output)
  end
end
