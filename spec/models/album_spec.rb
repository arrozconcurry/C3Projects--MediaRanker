require 'rails_helper'
require 'support/shared_examples_for_media_models'

RSpec.describe Album, type: :model do
  describe Album do
    it_behaves_like "a medium"
  end
end