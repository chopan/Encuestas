module EncuestasHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      if association.to_s == "opciones"
       render  association.to_s.singularize + 'es',:content_type => 'text/html', :f => builder
      else
        render  association.to_s.singularize + 's',:content_type => 'text/html', :f => builder
      end
    end
    link_to_function(name, raw("add_fields(this, '#{association}', '#{escape_javascript(fields)}')"))
 
  end

end
