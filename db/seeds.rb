require 'csv'

Customer.destroy_all
customers_file_path = "./db/csv_data/customers.csv"
CSV.foreach(customers_file_path, :headers => :true, header_converters: :symbol) do |row|
 Customer.create!( {
    id: row[:id],
    first_name: row[:first_name],
    last_name: row[:last_name],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Merchant.destroy_all
merchants_file_path = "./db/csv_data/merchants.csv"
CSV.foreach(merchants_file_path, :headers => :true, header_converters: :symbol) do |row|
 Merchant.create!( {
    id: row[:id],
    name: row[:name],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Item.destroy_all
items_file_path = "./db/csv_data/items.csv"
CSV.foreach(items_file_path, :headers => :true, header_converters: :symbol) do |row|
 Item.create!( {
    id: row[:id],
    name: row[:name],
    description: row[:description],
    unit_price: row[:unit_price],
    merchant_id: row[:merchant_id],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Invoice.destroy_all
invoices_file_path = "./db/csv_data/invoices.csv"
CSV.foreach(invoices_file_path, :headers => :true, header_converters: :symbol) do |row|
 Invoice.create!( {
    id: row[:id],
    customer_id: row[:customer_id],
    merchant_id: row[:merchant_id],
    status: row[:status],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

InvoiceItem.destroy_all
invoice_items_file_path = "./db/csv_data/invoice_items.csv"
CSV.foreach(invoice_items_file_path, :headers => :true, header_converters: :symbol) do |row|
 InvoiceItem.create!( {
    id: row[:id],
    item_id: row[:item_id],
    invoice_id: row[:invoice_id],
    quantity: row[:quantity],
    unit_price: row[:unit_price],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Transaction.destroy_all
transactions_file_path = "./db/csv_data/transactions.csv"
CSV.foreach(transactions_file_path, :headers => :true, header_converters: :symbol) do |row|
 Transaction.create!( {
    id: row[:id],
    invoice_id: row[:invoice_id],
    credit_card_number: row[:credit_card_number],
    result: row[:result],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

require "pry"; binding.pry
