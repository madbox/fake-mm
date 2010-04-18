# -*- coding: undecided -*-
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

  def expand_comment( string, *opts )
    options = opts.extract_options!.stringify_keys
    options[:truncate_to] ||= 200
    options[:expand_to_height] ||= 196
    if string.length > options[:truncate_to]
      ERB::Util.h( string.mb_chars[1..options[:truncate_to] - 5] ) + %Q{ <a href="#" onclick="e = $(this).parent(); e.html('#{ ERB::Util.h(string.gsub(/\s/, " ") ) }'); e.parent().animate({ height: #{options[:expand_to_height]}}); return false">...</a> }
    else
      string
    end
  end

  def comment_count_string( number )
    raise ArgumentError, "Numeric expected" unless number.kind_of? Numeric
  end

end
