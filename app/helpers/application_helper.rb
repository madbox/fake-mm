# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def styled_date datetime
    raise ArgumentError, "Kind of DateTime expected, but #{datetime.class} got" unless datetime.kind_of?( Date ) || datetime.nil? || datetime.kind_of?( ActiveSupport::TimeWithZone )
    if datetime.nil?
      "---"
    else
      Russian::strftime( datetime, "%d %B %Y").split.map{|w|w.mb_chars.capitalize}.join(" ")
    end
  end
  
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
      ERB::Util.h( string.mb_chars[0..options[:truncate_to] - 5] ) + %Q{ <a href="#" onclick="e = $(this).parent(); e.html('#{ ERB::Util.h(string.gsub(/\s/, " ") ) }'); return false">...</a> }
    else
      string
    end
  end

  def comment_count_string( number )
    raise ArgumentError, "Numeric expected" unless number.kind_of? Numeric
  end

  def small_form_item model, prop_name, value 
    returning '' do |text|
      text << %Q{<div><p>#{I18n.t("activerecord.attributes.#{model}.#{prop_name}")}</p>}
      text << %Q{<span>#{I18n.t("activerecord.tips.#{model}.#{prop_name}")}</span>} if I18n.t("activerecord.tips")[model.to_sym] && I18n.t("activerecord.tips")[model.to_sym][prop_name.to_sym]
      text << %Q{<span>#{value}</span></div>}
    end
  end

end

class ActionView::Helpers::FormBuilder
  def gender_select *args
    "Мужской #{radio_button( :gender, 'male')} Женский #{radio_button( :gender, 'female')} Другой #{radio_button( :gender, 'other')}"
  end
end
