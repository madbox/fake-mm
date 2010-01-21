# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def styled_field kind, object, prop_name, *args
    if kind == 'text'
      %Q{ <div class="field_label"><label>#{I18n.t("activerecord.attributes.#{object.class.name.underscore}.#{prop_name.to_s}")}</label>: #{object.send prop_name.to_sym}</div> }
    elsif kind == 'edit'
      builder = args.shift
      builder_method = args.shift
      %Q{<div class="field_label">#{builder.label prop_name.to_sym}</div>\n} + 
      %Q{<div class="field">#{builder.send( builder_method, prop_name.to_sym )}</div> }
    else
      raise ArgumentError, "Unknown field type '#{kind}'"
    end
  end

end
