module OrderLinesHelper
  def  submit_button_mini
    blueprint_submit_button(:title => t('general.accept'), :alt => t('general.accept'), :class => 'small', :text => nil)
  end
end
