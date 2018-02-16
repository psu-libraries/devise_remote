# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DeviseRemote::HttpHeaderAuthenticatableBehavior do
  before(:all) do
    class SampleStrategy
      include DeviseRemote::HttpHeaderAuthenticatableBehavior
    end
  end

  after(:all) do
    ActiveSupport::Dependencies.remove_constant('SampleStrategy')
  end

  describe '#valid_user?' do
    subject { SampleStrategy.new.valid_user?(headers) }

    context 'in a production environment' do
      let(:production) { ActiveSupport::StringInquirer.new('production') }

      before { allow(Rails).to receive(:env).and_return(production) }
      context 'using REMOTE_USER' do
        let(:headers) { { 'REMOTE_USER' => 'abc123' } }

        it { is_expected.to be(true) }
      end
      context 'using HTTP_REMOTE_USER' do
        let(:headers) { { 'HTTP_REMOTE_USER' => 'abc123' } }

        it { is_expected.to be(false) }
      end
      context 'using no header' do
        let(:headers) { {} }

        it { is_expected.to be(false) }
      end
    end
    context 'in a development or test environment' do
      context 'using REMOTE_USER' do
        let(:headers) { { 'REMOTE_USER' => 'abc123' } }

        it { is_expected.to be(true) }
      end
      context 'using HTTP_REMOTE_USER' do
        let(:headers) { { 'HTTP_REMOTE_USER' => 'abc123' } }

        it { is_expected.to be(true) }
      end
      context 'using no header' do
        let(:headers) { {} }

        it { is_expected.to be(false) }
      end
    end
  end
end
