# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                           :bigint           not null, primary key
#  insales_application_password :string           not null
#  insales_subdomain            :string           not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  insales_id                   :integer          not null
#
# Indexes
#
#  index_accounts_on_insales_id         (insales_id) UNIQUE
#  index_accounts_on_insales_subdomain  (insales_subdomain) UNIQUE
#
class Account < ApplicationRecord
  encrypts :insales_application_password

  validates :insales_id, presence: true, uniqueness: true
  validates :insales_subdomain, presence: true, uniqueness: true
  validates :insales_application_password, presence: true
end
