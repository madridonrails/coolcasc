class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :code
      t.string :corporate_name, :null => false
      t.string :cif
      t.string :official_address

      t.float :charge

      t.string :commercial_name
      t.string :site
      t.text :notes

      t.text :delivery_address
      t.string :delivery_contact
      
      t.string :contact_person
      t.string :contact_mail
      t.string :contact_phone
      t.string :contact_mobile
      t.string :contact_fax

      t.string :buying_person
      t.string :buying_mail
      t.string :buying_phone
      t.string :buying_mobile
      t.string :buying_fax

      t.string :paying_person
      t.string :paying_mail
      t.string :paying_phone
      t.string :paying_mobile
      t.string :paying_fax

      t.integer :payment_id
      t.string :payment_account
      t.integer :payment_days

      t.integer :sales_manager_id

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
