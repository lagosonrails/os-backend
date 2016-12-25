require 'rails_helper'

RSpec.describe Address, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#full_address" do
    subject { create(:address) }

    it 'should give the full address of the location' do
      expect(subject.full_address).to eql([
                                            subject.address_1,
                                            subject.address_2,
                                            subject.city,
                                            subject.state,
                                            subject.postal_code,
                                            subject.country
                                          ].compact.join(', ')
                                          )
    end
  end
end
