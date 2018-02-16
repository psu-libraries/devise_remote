# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Devise::Models::HttpHeaderAuthenticatable do
  before(:all) do
    class SampleModel
      include Devise::Models::HttpHeaderAuthenticatable
    end
  end

  after(:all) do
    ActiveSupport::Dependencies.remove_constant('SampleModel')
  end

  let(:model) { SampleModel.new }

  describe '#after_database_authentication' do
    specify { expect(model.after_database_authentication).to be_nil }
  end
end
