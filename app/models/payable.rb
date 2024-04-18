class Payable < ApplicationRecord
  belongs_to :payment_method
  belongs_to :buffet
end
