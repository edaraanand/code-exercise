require 'rails_helper' # Assume we have these files
require 'spec_helper'

RSpec.describe Party, type: :model do

  context 'validations' do
    describe 'factory' do
      it 'is valid' do
        party = FactoryGirl.build :party
        expect(party).to be_valid
      end
    end

    describe 'validation presence true' do
      it { should validate_presence_of :host_name }
      it { should validate_presence_of :host_email }
      it { should validate_presence_of :venue }
      it { should validate_presence_of :location }
      it { should validate_presence_of :theme }
      it { should validate_presence_of :when }
      it { should validate_presence_of :guest_names }
    end
  end

    describe 'order_query' do
      # Can repeat this for other parameters
      context 'sort by venue' do
        let(:party1) { FactoryGirl.create :party, :venue => 'San Antonio' }
        let(:party2) { FactoryGirl.create :party, :venue => 'Dallas' }
        let(:party3) { FactoryGirl.create :party, :venue => 'Austin' }
        it 'returns venue in asc order' do
          expect(Request.order_query_with_relations('host_name', 'asc').scope).to eq [party3, party2, party1]
        end
        it 'returns venue in desc order' do
          expect(Request.order_query_with_relations('host_name', 'desc').scope).to eq [party1, party2, party3]
        end
      end
    end
end