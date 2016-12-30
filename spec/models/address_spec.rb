# == Schema Information
#
# Table name: addresses
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  address_1      :string
#  address_2      :string
#  city           :string
#  state          :string
#  country        :string
#  postal_code    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  latitude       :float
#  longitude      :float
#  archive_number :string
#  archived_at    :datetime
#
# Indexes
#
#  index_addresses_on_company_id  (company_id)
#

require 'rails_helper'

RSpec.describe Address, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#full_address" do
    subject { create(:address_with_full_address) }

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

  describe "Geocoding Actions(#geocode|#reverse_geocode)" do
    
    context "when there is an address but no coordinates" do
      subject { build(:address_with_full_address) }

      it "should geocode the address" do
        expect(subject).to receive(:geocode)
        expect(subject).not_to receive(:reverse_geocode)

        subject.save
      end
    end

    context "when there are coordinates but no addresses" do
      subject { build(:address_with_coordinates) }

      it "should reverse geocode the address" do
        expect(subject).to receive(:reverse_geocode)
        expect(subject).not_to receive(:geocode)

        subject.save
      end
    end
  end
end
