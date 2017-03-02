require 'rails_helper'
  
RSpec.describe Book, type: :model do
  let!(:category) {Category.create(name: "Ruby", active: true)}
  subject { described_class.new(
    title: "The Well-Grounded Rubyist",
    category: category,
    proposal_date: 1.year.ago.to_date,
    contract_date: 10.months.ago.to_date,
    published_date: 3.weeks.ago.to_date,
    units_sold: 1000,
    notes: "It is a very good book for learning Ruby.") }
    
  it "belongs to category association" do
     assoc = described_class.reflect_on_association(:category) 
     expect(assoc.macro).to eq :belongs_to
  end
  
  it "has_many book_authors association" do
     assoc = described_class.reflect_on_association(:book_authors) 
     expect(assoc.macro).to eq :has_many
  end
  
  it "has_many authors through book_authors association" do
     assoc = described_class.reflect_on_association(:authors) 
     expect(assoc.macro).to eq :has_many
     expect(assoc.options[:through]).to eq :book_authors
  end  
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid    
  end
  
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).not_to be_valid   
  end
  
  it "accepts valid units sold" do
      valid_units = [1000, 0]

      valid_units.each do |valid_unit|
          subject.units_sold = valid_unit
          expect(subject).to be_valid
      end
  end

  it "doesn't accept invalid units sold" do
      invalid_units = [-1000, 3.149, "bad"]

      invalid_units.each do |invalid_unit|
          subject.units_sold = invalid_unit
          expect(subject).to_not be_valid
      end
  end 
  
  it "accepts valid proposal_dates" do
      valid_dates = [1.year.ago, 11.months.ago]

      valid_dates.each do |valid_date|
          subject.proposal_date = valid_date
          expect(subject).to be_valid
      end
  end

  it "doesn't accept invalid proposal_dates" do
      invalid_dates = [1.week.from_now, "bad", nil]

      invalid_dates.each do |invalid_date|
          subject.proposal_date = invalid_date
          expect(subject).to_not be_valid
      end
  end
  
    it "accepts valid contract_dates" do
      valid_dates = [1.year.ago, 11.months.ago]

      valid_dates.each do |valid_date|
          subject.contract_date = valid_date
          expect(subject).to be_valid
      end
  end

  it "doesn't accept invalid contract_dates" do
      invalid_dates = [1.week.from_now, "bad", nil]

      invalid_dates.each do |invalid_date|
          subject.contract_date = invalid_date
          expect(subject).to_not be_valid
      end
  end
end
