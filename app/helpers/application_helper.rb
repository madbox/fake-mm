# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def styled_field kind, object, prop_name, *args
    if kind == 'text'
      %Q{ <p><b>#{prop_name}</b>#{object.send prop_name.to_sym}</p> }
    elsif kind == 'edit'
      builder = args.shift
      builder_method = args.shift
      %Q{<p>#{builder.label prop_name.to_sym}<br />\n} + 
      %Q{#{builder.send( builder_method, prop_name.to_sym )}</p> }
    else
      raise ArgumentError, "Unknown field type '#{kind}'"
    end
  end

end
