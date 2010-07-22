namespace :coolcasc do
  namespace :init do
    desc "initialize sales managers"
    task :sales_managers => :environment do
      init_sales_managers
    end

    desc 'Initialize cover collections'
    task :cover_collections => :environment do
      init_cover_collections
    end

    desc 'Initialize cover patterns'
    task :cover_patterns => :environment do
      init_cover_patterns
    end

    desc 'Initialize client'
    task :clients => :environemt do
      init_clients
    end

    desc 'Initialize order'
    task :orders => :environment do
      init_orders
      init_order_lines
    end

    desc 'Initialize products'
    task :orders => :environment do
      init_products
    end

    desc 'Initialize payments'
    task :payments => :environment do
      init_payments
    end

    desc 'Intialize marks'
    task :marks => :environment do
      init_marks
    end

    desc "Complete initialization"
    task :all => :environment do
      init_marks
      init_sales_managers
      init_payments
      init_cover_collections
      init_cover_patterns
      init_products
      init_clients
      init_orders
      init_order_lines
    end
  end

  def init_marks
    puts 'Initializing marks'
    marks = ['Marcado 1', 'Marcado 2', 'Marcado 3']
    marks.each do |m|
      mark = Mark.find_or_initialize_by_name m
      if mark.save
        puts "#{mark.name} created"
      else
        puts "Errors while creating #{mark.name}"
      end
    end
  end

  def init_orders
    puts 'Initializing orders'
    o = Order.find_or_initialize_by_code '0000001'
    o.paid_date = '01012010'
    o.delivery_date = '01012010'
    o.order_date = '01012010'
    c = Client.find_by_code('00000001')
    o.client = c
    if o.save
      puts 'Order created'
    else
      puts 'Errors while creating order'
    end
  end

  def init_order_lines
    puts 'Initializing order_lines'
    ol = OrderLine.new
    ol.cover_pattern = CoverPattern.find(:all)[0]
    ol.product = Product.find_by_code('0000001')
    ol.count = 10
    ol.order_id = Order.find_by_code '0000001'
    if ol.save
      puts 'Order line created'
    else
      puts 'Errors while creating order line'
    end
  end

  def init_products
    puts 'Initializing products'
    p = Product.find_or_initialize_by_code '0000001'
    p.name = 'Producto 1'
    p.cover_collection = CoverCollection.find(1)
    p.retail_price = 10
    if p.save
      puts 'Product created'
    else
      puts 'Errors while creating product'
    end
  end

  def init_sales_managers
    puts 'Initializing sales_manager'
    sm = SalesManager.find_or_initialize_by_email 'sales_manager_1@coolcasc.com'
    sm.cif = '123456789'
    sm.official_address = 'Calle Real, 9 1ºA 280001 Madrid'
    sm.name = 'Sales Manager Pérez'
    sm.corporate_name = 'Sales Manager SL'
    if sm.save
      puts 'Sales managers created'
    else
      puts 'Errors while creating sales manager'
    end
  end

  def init_clients
    puts 'Initializing clients'
    c = Client.find_or_initialize_by_code '00000001'
    c.cif = 'B000001'
    c.corporate_name = 'Cliente 1'
    c.official_address = 'Dirección del cliente 1'
    c.commercial_name = 'Cliente (nombre comercial) 1'
    c.sales_manager = SalesManager.find_by_email('sales_manager_1@coolcasc.com')
    c.payment = Payment.find_by_name('Transferencia')
    if c.save
      puts 'Client created'
    else
      puts 'Error while creating client'
    end
  end

  def init_cover_collections
    
    puts 'Initializing cover_collections'
    covers = ['Estampados', 'Estampados cool', 'Craft', 'Formas', 'Animales']
    covers.each do |c|
      cc = CoverCollection.find_or_initialize_by_name c
      if cc.save
        puts "#{cc.name} created"
      else
        puts "Errors while creating #{cc.name}"
      end
    end
  end

  def init_payments
    puts 'Initializing payments'
    payments = ['Transferencia', 'Cheque', 'Domiciliación', 'Confirming']
    payments.each do |p|
      pm = Payment.find_or_initialize_by_name p
      if pm.save
        puts "#{pm.name} created"
      else
        puts "Errors while creating #{pm.name}"
      end
    end
  end

  def init_cover_patterns

    puts 'Initializing cover_patterns'
    patterns = ['Jet', 'Jet ski', 'Integral', 'Integral cross', 'Ciclomotor', 'Bicicleta']
    patterns.each do |p|
      cp = CoverPattern.find_or_initialize_by_pattern p
      if cp.save
        puts "#{cp.pattern} created"
      else
        puts "Errors while creating #{cp.pattern}"
      end
    end
  end
end
=begin
  desc "initialize db (initial load of master data)"
  task :initialize => :environment do
    puts "please confirm you want to initialize your db contents  (type 'all' to initialize all users, 'admin' to initialize only the admin user or 'locales' to initilize multilanguage. Type anything else to skip)"
    s_answer = $stdin.gets
    if s_answer.chomp == 'admin' || s_answer.chomp == 'all'
      init_admin_user
      if s_answer.chomp == 'all'
        init_sales_user
        init_stock_user
      end
    elsif s_answer.chomp == 'locales'
      init_locales
    else
      puts 'initialization skipped'
     end
  end #task do

  def init_admin_user
    puts 'initializing admin user'
    u = User.find_or_initialize_by_email 'admin@coolcasc.com'
    u.login = 'admin'
    u.is_admin = true
    u.password = 'admin' if u.new_record?
    u.password_confirmation = 'admin' if u.new_record?
    if u.save
      puts 'done'
    else
      puts 'error'
    end
  end  

  def init_sales_user
    puts 'initializing sales user'
    u = User.find_or_initialize_by_email 'sales@coolcasc.com'
    u.login = 'sales'
    u.is_sales = true
    u.password = 'sales' if u.new_record?
    u.password_confirmation = 'sales' if u.new_record?
    if u.save
      puts 'done'
    else
      puts 'error'
    end
  end  
  
  def init_stock_user
    puts 'initializing stock user'
    u = User.find_or_initialize_by_email 'stock@coolcasc.com'
    u.login = 'stock'
    u.is_stock = true
    u.password = 'stock' if u.new_record?
    u.password_confirmation = 'stock' if u.new_record?
    if u.save
      puts 'done'
    else
      puts 'error'
    end
  end  
  
  def init_locales
    l1 = Locale.find_or_initialize_by_code 'en-UK'
    l1.name='English'
    l1.save
    
    l2 = Locale.find_or_initialize_by_code 'es-ES'
    l2.name='Castellano'
    l2.save!
    
    User.find(:all).each do |user|
      user.locale = l2
      user.save
    end
  end  
end
=end
