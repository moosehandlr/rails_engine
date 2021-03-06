require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:invoice_items).through :invoices}
    it {should have_many(:transactions).through :invoices}
  end

  describe 'methods' do
    before :each do
      @m1, @m2, @m3, @m4, @m5, @m6 = create_list(:merchant, 6)
      # one item per merchant
      @it1 = create(:item, merchant: @m1)
      @it2 = create(:item, merchant: @m2)
      @it3 = create(:item, merchant: @m3)
      @it4 = create(:item, merchant: @m4)
      @it5 = create(:item, merchant: @m5)
      @it6 = create(:item, merchant: @m6)
      # one invoice for each merchant, status=shipped, also set the created_at
      @iv1 = create(:invoice, merchant: @m1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
      @iv2 = create(:invoice, merchant: @m2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
      @iv3 = create(:invoice, merchant: @m3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')
      @iv4 = create(:invoice, merchant: @m4, status: 'shipped', created_at: '2020-04-04T00:00:00 UTC')
      @iv5 = create(:invoice, merchant: @m5, status: 'shipped', created_at: '2020-05-05T00:00:00 UTC')
      @iv6 = create(:invoice, merchant: @m6, status: 'packaged', created_at: '2020-06-06T00:00:00 UTC')
      # one invoice_item for each invoice, low quantity and price to high quantity and price
      @ii1 = create(:invoice_item, invoice: @iv1, item: @it1, quantity: 60, unit_price: 1) # rev: $60
      @ii2 = create(:invoice_item, invoice: @iv2, item: @it2, quantity: 55, unit_price: 2) # rev: $110
      @ii3 = create(:invoice_item, invoice: @iv3, item: @it3, quantity: 30, unit_price: 5) # rev: $150
      @ii4 = create(:invoice_item, invoice: @iv4, item: @it4, quantity: 40, unit_price: 7) # rev: $280
      @ii5 = create(:invoice_item, invoice: @iv5, item: @it5, quantity: 50, unit_price: 9) # rev: $450
      @ii6 = create(:invoice_item, invoice: @iv6, item: @it6, quantity: 60, unit_price: 11) # rev: $660
      # one transaction for each invoice which are result=success
      @t1 = create(:transaction, invoice: @iv1, result: 'success')
      @t2 = create(:transaction, invoice: @iv2, result: 'success')
      @t3 = create(:transaction, invoice: @iv3, result: 'success')
      @t4 = create(:transaction, invoice: @iv4, result: 'success')
      @t5 = create(:transaction, invoice: @iv5, result: 'success')
      @t6 = create(:transaction, invoice: @iv6, result: 'failed')
    end

    it ".most_revenue" do
      expect(Merchant.most_revenue(3)).to eq([@m5, @m4, @m3])
    end

    it ".most_items" do
      expect(Merchant.most_items(3)).to eq([@m1, @m2, @m5])
    end

    # it "revenue" do
    #   it5 = create(:item, merchant: @m1)
    #   ii7 = create(:invoice_item, invoice: @iv1, item: @it5, quantity: 40, unit_price: 1) # rev: $40
    #   expect(@m1.revenue).to eq(100)
    # end
  end
end
