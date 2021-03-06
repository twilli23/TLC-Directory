# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchTerm, type: :model do
  let(:search_term) { FactoryBot.create :search_term }

  context 'validations' do
    it { should validate_presence_of(:term) }
    it { should validate_length_of(:term).is_at_least(2) }
    it { should validate_length_of(:term).is_at_most(255) }

    it { should validate_presence_of(:term_count) }
    it { should validate_numericality_of(:term_count) }
    it { should_not allow_value(0).for(:term_count) }
  end

  context 'valid object' do
    it 'expects search_term to be valid' do
      expect(search_term).to be_valid
    end
  end

  context 'testing update' do
    it 'test counter update' do
      count = search_term.term_count + 1
      search_term.increase_count
      expect(search_term.term_count).to equal count
      expect(search_term).to be_valid
    end
  end
end
