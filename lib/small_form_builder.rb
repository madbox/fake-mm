# -*- coding: utf-8 -*-
# Билдер выводящий дополнительную разметку.
# Сейчас с каждым полем выподится то, что делает метод +ApplicationHelper#form_element+
# Т.е вызовы хэлперов должны быть внутри +ApplicationHelper#form_tbl+
# Все хэлперы принимают опцию :annotation, содержимое которой будет вставляться в третюю колонку

class SmallFormBuilder < ActionView::Helpers::FormBuilder
  helpers = field_helpers +
    %w{date_select datetime_select time_select} -
#    %w{collection_select select country_select time_zone_select} -
    %w{hidden_field label fields_for} # Don't decorate these

  include ApplicationHelper

  helpers.each do |name|
    define_method(name) do |field, *args|
      options = args.last.is_a?(Hash) ? args.pop : {}
      helper_name = extract_helper_name options
      options[:class] = 'small-form-input' unless options.has_key? :class
      str = nil
      # А теперь супер-костыль, т.к. block_given? не работает внутри define_method. Перинимаем блок из параметров.
      str = options[:block].call( super( field, options ) ) if options[:block]
      self.send helper_name, options[:model_name] || @object_name, field, str || super( field, options )
    end
  end

  def select( field, *args )
    options = args.last.is_a?(Hash) ? args.pop : {}
    helper_name = extract_helper_name options
    str = nil
    str = yield( super ) if block_given?
    self.send helper_name,  options[:model_name] || @object_name, field, str || super
  end
  
  # Просто текст в виде стандартного элемента формы. Нужен, например для не изменяемых полей
  def text(field, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    helper_name = extract_helper_name options
    self.send helper_name,  options[:model_name] || @object_name, field, (args || []).shift || @object.send(field)
  end

  private
  
  def extract_helper_name hash
    hash[:helper]  || 'small_form_item'
  end

end
