module OrdersHelper

  def show_delivery_note_actions(order, options = {})
    html = ''
    if order.delivery_note_pendant?
      html += link_to image_tag('new.jpg', :alt => t('order.create_delivery_note'), :title => t('order.create_delivery_note')), new_order_delivery_note_path(order.id)
    else
      html += link_to image_tag('view.png', :alt => t('order.view_delivery_note'), :title => t('order.view_delivery_note')), delivery_note_path(order.delivery_note)
      html += print_icon(order.delivery_note)
      html += print_to_pdf_icon(order.delivery_note)
      html += link_to image_tag('edit.png', :alt => t('order.edit_delivery_note'), :title => t('order.edit_delivery_note')),edit_delivery_note_path(order.delivery_note)

    end
  end

  def show_invoice_actions(order, options = {})
    html = ''
    if order.invoice_pendant?
      html += link_to image_tag('new.jpg', :alt => t('order.create_invoice'), :title => t('order.create_invoice')), new_order_invoice_path(order.id)
    else
      html += link_to image_tag('view.png', :alt => t('order.view_invoice'), :title => t('order.view_invoice')), invoice_path(order.invoice)
      html += print_icon(order.invoice)
      html += print_to_pdf_icon(order.invoice)
      html += link_to image_tag('edit.png', :alt => t('order.edit_invoice'), :title => t('order.edit_invoice')), edit_invoice_path(order.invoice)
      html += manage_issue(order)
    end
  end

  def manage_issue(order)
#    html = ''
#    if order.completed?
      html = link_to(t("order.events.#{order.aasm_events_for_current_state[0].to_s}"), {:action => order.aasm_events_for_current_state[0], :id => order.id})
#    else
#      html += link_to 'cancelar', :action => 'cancel_issue_invoice', :id => order.id
#    end
  end

  def print_icon(object, html_options={})
    html_options[:popup] = true
    link_to image_tag('printer.png', :class => 'printing_icon', :alt => t('print.print'), :title => t('print.print')), {:controller => "#{object.class.name}s".underscore, :action => :print, :id => object.id}, html_options
  end

  def print_to_pdf_icon(object, options={})
    link_to image_tag('pdf.png', :class => 'printing_icon', :alt => t('print.print_to_pdf'), :title => t('print.print_to_pdf')), {:controller => "#{object.class.name}s".underscore, :action => 'print', :id => object.id, :with_header => 1}, :popup => true 
  end
  
  def print(object, html_options={})
    html_options[:popup] = true
    link_to image_tag('printer.png', :class => 'printing', :alt => t('print.print'), :title => t('print.print')), {:action => 'print', :id => object.id}, html_options
  end

  def print_to_pdf(object, options={})
    link_to image_tag('pdf.png', :class => 'printing', :alt => t('print.print_to_pdf'), :title => t('print.print_to_pdf')), {:action => 'print', :id => object.id, :with_header => 1}, :popup => true 
  end

end
