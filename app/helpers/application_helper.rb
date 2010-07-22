# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def new_item_button(url, options = {})
    options.merge!({:class => 'new_item_button', :image => 'newitem.png'})
    html = "<div class=\"span-24 button-section\">" + blueprint_button(url, options) + '</div>'
    return html
  end

  def submit_button
    blueprint_submit_button(:title => t('general.submit_form'), :alt => t('general.submit_form'))
  end

  def go_back_button(link)
    blueprint_go_back_button(link, :title => t('general.go_back'), :alt => t('general.go_back'))
  end

  def paginate(object)
    will_paginate(object, :prev_label => t('general.pagination.previous'), :next_label => t('general.pagination.next'), :params => params.clone.delete_if{|k,v| k == 'controller' || k == 'action' || k == 'page'})
  end

  def blueprint_image_tag(source, options = {})
    return image_tag((path_to_stylesheet("blueprint/#{source}")), options)
  end
  

  def blueprint_button(link, options = {})
    custom_class = (options.has_key? :class) ? options[:class] : ''
    title = (options.has_key? :title) ? "#{options[:title]} " : ''
    custom_class = (options.has_key? :class) ? options[:class] : ''
    image = (options.has_key? :image) ? options[:image] : ''
    unless image.blank?
      image_alt = (options.has_key? :image_alt) ? options[:image_alt] : nil
      image_title = (options.has_key? :image_title) ? options[:image_title] : ''
      imagetag = image_tag(image, :alt => image_alt, :title => image_title)
    end
    return link_to "#{title}#{imagetag}", link, :class => "button #{custom_class}"
  end

  def blueprint_submit_button(options = {})
    title = (options.has_key? :title) ? "#{options[:title]} " : t('general.accept')
    alt = (options.has_key? :alt) ? options[:alt] : t('general.accept')
    custom_class = (options.has_key? :class) ? options[:class] : ''
    text = (options.has_key? :text) ? options[:text] : ''
    return "<button type=\"submit\" class=\"button positive #{custom_class}\">#{text}#{blueprint_image_tag('plugins/buttons/icons/tick.png', :alt => alt)}</button>"
  end

  def blueprint_go_back_button(link, options = {})
    title = (options.has_key? :title) ? "#{options[:title]} " : t('general.go_back')
    alt = (options.has_key? :alt) ? options[:alt] : t('general.go_back')
    custom_class = (options.has_key? :class) ? options[:class] : ''
    return link_to "#{title}#{blueprint_image_tag('plugins/buttons/icons/cross.png', :alt => alt, :class => 'button_icon')}", link, :class => "button negative", :title => title
  end

  def object_messages(obj = nil)
    if !obj.nil? && !obj.errors.blank?
      str_msg = '<div id="message" class=" span-24 message last failure"><p>' + obj.errors.full_messages.join('</p><p>') + '</p></div id="message">'
    elsif !flash[:error].blank?
      str_msg = '<div id="message" class=" span-24 message last failure"><p>' + flash[:error] + '</p></div id="message">'
    elsif !flash[:notice].blank?
      str_msg = '<div id="message" class=" span-24 message last notice"><p>' + flash[:notice] + '</p></div id="message">'
    elsif !flash[:success].blank?
      str_msg = '<div id="message" class=" span-24 message last success"><p>' + flash[:success] + '</p></div id="message">'
    else
      str_msg = ''
    end
    flash[:error] = ''
    flash[:notice] = ''
    flash[:message] = ''
    return str_msg
  end

  def label_attribute(obj, field)
    return label obj, field, t("activerecord.attributes.#{obj.to_s}.#{field.to_s}")
  end

  def list_from_record(obj, options = {})

    res = {}
    name_field = (options.has_key? :name) ? options[:name] : 'name'
    id_field = (options.has_key? :id) ? options[:id] : 'id'
    conditions = (options.has_key? :conditions) ? options[:conditions] : {}

    res[options[:header]] = nil if options.has_key? :header

    obj.constantize.find(:all, conditions).map {|o|
     res[o.send(name_field)] = o.send(id_field)
    }
    res.sort
  end

  def show_state_machine_transitions(object, options = {})
    html = ''
    transitions = object.aasm_events_for_current_state rescue []

    if !options[:except].blank?
      transitions = transitions - options[:except]
    elsif !options[:only].blank?
      transitions = transitions & options[:only]
    end

    unless transitions.empty?
      html = []
      transitions.each {|t|
        html << link_to(t("#{object.class.name.downcase}.events.#{t.to_s}"), :action => "#{t.to_s}", :id => object.id )
      }
    end

    return html.join ' | ' rescue ''
  end
=begin
  def order_transitions_by_user

    options = {}
     
    if current_user.is_stock?
      options = {:only => [:complete]}
    end

    return options

  end

  def sale_transitions_by_user

    options = {}

    if current_user.is_stock?
      options = {:only => [:fabricate, :send_sale]}
    elsif current_user.is_sales?
      options = {:only => [:complete]}
    end
    
  end
  def get_order(field_name)
    order_hash = {:order => field_name}
    if (@query_order == field_name)
      order_hash[:direction] = (@direction == 'asc' ? 'desc' : 'asc')
    else
      order_hash[:direction] = 'asc'
    end
    return order_hash
  end


  def list_providers
    res = {}
    Provider.find(:all).map {|p|
     res[p.name] = p.id
    }
    res
  end

  def list_raw_products
    res = {}
    RawProduct.find(:all, :order => 'name').map {|r|
      res[r.name] = r.id
    }
    res
  end


  def list_clients
    res = {}
    Client.find(:all, :order => 'name').map {|r|
      res[r.name] = r.id
    }
    res
  end

  def list_products
    res = {}
    Product.find(:all, :order => 'name').map {|r|
      res[r.name] = r.id
    }
    res
  end

  def list_raw_products_for_provider(provider_id)
    res = {}
    RawProduct.find_all_by_provider_id(provider_id, :order => 'name').map {|r|
      res[r.name] = r.id
    }
    res
  end


  # 'aaaammdd' ->  'aaaa/mm/dd'  or ''
  def int_date_to_string(idate)
      vdate = Integer(idate)
      if (vdate> 10000000 && vdate<= 99999999)
        s_idate = idate.to_s
        "#{(s_idate[0..3])}/#{(s_idate[4..5])}/#{(s_idate[6..7])}"
      else
        ""
      end
  end


    #output 'aaaammdd'
  def get_current_date
    now_time = Time.now
    month = now_time.month
    day = now_time.day
    m = month <10 ? "0#{month}":month.to_s
    d = day <10 ? "0#{day}":day.to_s
    "#{now_time.year}#{m}#{d}"
  end

  def get_date_select(obj, var, time)
    if (time == nil)
      #select_date Time.now, :prefix => "#{obj}[#{var}]"
      select_date(Time.now, {:prefix => "#{obj}[#{var}]", :order => [:year, :month, :day], :use_month_names => %w(1 2 3 4 5 6 7 8 9 10 11 12) })
    else
      select_date(time, { :prefix => "#{obj}[#{var}]", :order => [:year, :month, :day], :use_month_names => %w(1 2 3 4 5 6 7 8 9 10 11 12) })
    end
  end

  # 'aaaammdd' -> time
  def get_time_from_aaaammdd(idate)
    if (idate == nil)
      idate = get_current_date
    end
    s_idate = idate.to_s
    Time.local(s_idate[0..3].to_i,s_idate[4..5].to_i,s_idate[6..7].to_i,0,0,0,0)
  end
  
  def yes_or_no(object = false)
    unless object.nil? || object.blank? || !object
      return 'S&iacute;'
    else
      return 'No'
    end
  end

  def select_locales_for_back(str_object, object)
    select(str_object, 'locale_id', Locale.find_non_master.map{|l| [l.code, l.id]} , {:include_blank => object.new_record?})
  end

  def select_locales_for(str_object, object)
    select(str_object, 'locale_id', Locale.find_non_master.map{|l| [l.code, l.id]} )
  end
=end
end
