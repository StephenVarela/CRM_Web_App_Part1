require 'pry'
gem 'activerecord', '=4.2.10'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')


class Contact < ActiveRecord::Base

  field :first_name, as: :string
  field :last_name, as: :string
  field :email, as: :string
  field :note, as: :text

  def self.check_column(options)
    check_array = ['first_name', 'last_name', 'email', 'note']

    if check_array.include?(options.keys[0])
      return true
    else
      puts "Error access specifier does not exist in the table"
      return false
    end
  end

  def full_name
    return "Full name: #{first_name} #{last_name}"
  end

end
Contact.auto_upgrade!
