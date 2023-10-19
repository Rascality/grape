# frozen_string_literal: true

describe Grape::Middleware::Auth::DSL do
  subject { Class.new(Grape::API) }

  let(:block) { -> {} }
  let(:settings) do
    {
      proc: block,
      realm: 'API Authorization',
      type: :http_basic
    }
  end

  describe '.http_basic' do
    it 'sets auth parameters' do
      subject.http_basic realm: 'my_realm', &settings[:proc]
      expect(subject.auth).to eq(realm: 'my_realm', type: :http_basic, proc: block)
    end
  end
end
