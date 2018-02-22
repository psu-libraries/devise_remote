# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Devise::Strategies::HttpHeaderAuthenticatable do
  subject { described_class.new(nil) }

  describe '#valid?' do
    context 'with a valid user' do
      before { allow(subject).to receive(:valid_user?).and_return(true) }
      it { is_expected.to be_valid }
    end

    context 'with an invalid user' do
      before { allow(subject).to receive(:valid_user?).and_return(false) }
      it { is_expected.not_to be_valid }
    end
  end

  describe 'authenticate!' do
    let(:request)   { double(headers: { 'HTTP_REMOTE_USER' => login }) }
    let(:mock_user) { double('User') }

    before { allow(subject).to receive(:request).and_return(request) }

    context 'with a new user' do
      let(:login) { 'newuser@example.com' }

      it 'creates the new user' do
        expect { subject.authenticate! }.to change { User.count }.by(1)
      end

      it 'populates LDAP attrs' do
        expect(User).to receive(:create).with(login: login, email: login).once.and_return(mock_user)
        expect(mock_user).to receive(:populate_attributes).once
        subject.authenticate!
      end

      it 'returns success' do
        expect(subject.authenticate!).to eq(:success)
      end
    end

    context 'with an existing user' do
      let(:login) { 'olduser@example.com' }

      before { User.create(login: login) }

      it 'does not create a new user' do
        expect { subject.authenticate! }.to change { User.count }.by(0)
      end

      it 'does not populate LDAP attrs' do
        expect(User).to receive(:find_by).with(login: login).once.and_return(mock_user)
        expect(mock_user).not_to receive(:populate_attributes)
        subject.authenticate!
      end

      it 'returns success' do
        expect(subject.authenticate!).to eq(:success)
      end
    end

    context 'without a user' do
      let(:login) { nil }

      it 'returns failure' do
        expect(subject.authenticate!).to eq(:failure)
      end
    end
  end
end
