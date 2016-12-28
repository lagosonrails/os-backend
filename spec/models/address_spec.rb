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
