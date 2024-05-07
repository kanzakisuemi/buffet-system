require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#presence' do
    it 'of content' do
      message = Message.new(content: nil)

      message.valid?
      result = message.errors.include?(:content)

      expect(result).to be true
    end
  end
end
