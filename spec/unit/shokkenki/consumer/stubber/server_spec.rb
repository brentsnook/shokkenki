require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/server'
require 'shokkenki/consumer/stubber/middleware'
require 'rack/handler/webrick'
require 'webmock/rspec'

describe Shokkenki::Consumer::Stubber::Server do

  let(:rack_app) { double('server', :to_s => 'appname') }
  let(:port) { 1234 }
  let(:host) { 'localhost' }
  let(:middleware) { double('middleware').as_null_object }
  let(:identify_url) { "http://localhost:1234#{Shokkenki::Consumer::Stubber::Middleware::IDENTIFY_PATH}" }

  subject do
    Shokkenki::Consumer::Stubber::Server.new(
      :app => rack_app,
      :port => port,
      :host => host
    )
  end

  before do
    allow(Shokkenki::Consumer::Stubber::Middleware).to receive(:new).with(rack_app).and_return(middleware)
  end

  let(:start_server) do
    subject.start
    subject.server_thread.join # to ensure thread finishes
  end

  context 'when created' do

    it 'uses the port given' do
      expect(subject.port).to eq(port)
    end

    it 'uses the host given' do
      expect(subject.host).to eq(host)
    end

    it 'uses the rack application given' do
      expect(subject.app).to eq(rack_app)
    end
  end

  context 'starting' do

    before do
      allow(Timeout).to receive(:timeout).and_yield
      allow(subject).to receive(:run)
      allow(subject).to receive(:responsive?).and_return(true)
    end

    context 'when server starts successfully' do

      before do
        start_server
      end

      it 'runs the rack app wrapped in middleware in a new thread' do
        expect(subject).to have_received(:run).with middleware, anything, anything
      end

      it 'starts the server on the configured port' do
        expect(subject).to have_received(:run).with anything, anything, port
      end

      it 'starts the server on the configured host' do
        expect(subject).to have_received(:run).with anything, host, anything
      end

      it 'waits for 10 seconds to ensure the server has started' do
        expect(Timeout).to have_received(:timeout).with 10
      end

    end

    context 'when server start times out' do

      before do
        allow(Timeout).to receive(:timeout).and_raise Timeout::Error
      end

      it 'fails' do
        expect { start_server }.to raise_error('Rack application appname timed out during boot')
      end
    end
  end

  context 'resetting errors' do

    before { subject.reset_error! }

    it 'resets the errors on the middleware' do
      expect(middleware).to have_received(:error=).with(nil)
    end

  end

  context 'errors' do

    before { allow(middleware).to receive(:error).and_return 'error!' }

    it 'are the middleware errors' do
      expect(middleware.error).to eq('error!')
    end

  end

  context 'running' do

    let(:stderr_logger) { double('stderr logger') }

    before do
      allow(Rack::Handler::WEBrick).to receive(:run)
      allow(WEBrick::Log).to receive(:new).and_return(stderr_logger)
      subject.run rack_app, host, port
    end

    context 'as a new Webrick instance' do
      it 'runs the given app' do
        expect(Rack::Handler::WEBrick).to have_received(:run).with(rack_app, anything)
      end

      it 'runs on the given port' do
        expect(Rack::Handler::WEBrick).to have_received(:run).with(anything, hash_including({:Port => port}))
      end

      it 'runs on the given host' do
        expect(Rack::Handler::WEBrick).to have_received(:run).with(anything, hash_including({:Host => host}))
      end

      # see http://ruby-doc.org/stdlib-1.9.3/libdoc/webrick/rdoc/WEBrick/HTTPServer.html
      it "doesn't write any access log" do
        expect(Rack::Handler::WEBrick).to have_received(:run).with(anything, hash_including({:AccessLog => []}))
      end

      it 'logs only to STDERR' do
        expect(Rack::Handler::WEBrick).to have_received(:run).with(anything, hash_including({:Logger => stderr_logger}))
        # nil logs to stderr
        # see http://ruby-doc.org/stdlib-1.9.3/libdoc/webrick/rdoc/WEBrick/BasicLog.html
        expect(WEBrick::Log).to have_received(:new).with(nil, 0)
      end
    end
  end

  context 'responsive?' do
    context 'when there is a server thread but it is not running' do
      let(:thread) { double('thread').as_null_object }

      before do
        allow(subject).to receive(:server_thread).and_return(thread)
        allow(thread).to receive(:join).with(0).and_return(thread)
      end

      it 'is not responsive' do
        expect(subject).to_not be_responsive
      end
    end

    describe 'request' do
      before do
        allow(subject).to receive(:is_app?).and_return(true)
      end

      context 'when the identity check results in a response that is a success' do
        before do
          stub_request(:get, identify_url).to_return(:body => '', :status => 200)
        end

        it 'is ok' do
          expect(subject).to be_responsive
        end
      end

      context 'when the identity check results in a response that is a redirect' do
        before do
          stub_request(:get, identify_url).to_return(:body => '', :status => 302)
        end

        it 'is ok' do
          expect(subject).to be_responsive
        end
      end

      context 'when the identity check results in a response that is neither success or a redirect' do

        before do
          stub_request(:get, identify_url).to_return(:body => '', :status => 402)
        end

        it 'is not ok :)' do
          expect(subject).to_not be_responsive
        end
      end

    end

    context 'when the identity check results in a response that is ok' do

      context 'when the body contains the rack app ID' do

        before do
          stub_request(:get, identify_url).to_return(:body => rack_app.object_id)
        end

        it 'is responsive' do
          expect(subject).to be_responsive
        end
      end

      context 'when the body does not contain the rack app ID' do
        before do
          stub_request(:get, identify_url).to_return(:body => 'sausages')
        end

        it 'is not responsive' do
          expect(subject).to_not be_responsive
        end
      end
    end

    # see https://github.com/jnicklas/capybara/commit/583c54cef55fd0d14814382e9c78c835a98451a5
    context 'when there is a system call error caused by network errors' do
      before do
        stub_request(:get, identify_url).to_raise(SystemCallError)
      end

      it 'is not responsive' do
        expect(subject).to_not be_responsive
      end
    end
  end

  context 'shutdown' do

    let(:thread) { double('thread').as_null_object }
    before do
      allow(subject).to receive(:server_thread).and_return(thread)
      subject.shutdown
    end

    it 'kills the server thread' do
      expect(thread).to have_received(:kill)
    end
  end

  context 'asserting everything is ok' do

    context 'when there is an error' do
      let(:error) { Exception.new 'server error' }
      before { allow(subject).to receive(:error).and_return error }

      it 'raises the error' do
        expect{ subject.assert_ok! }.to raise_error(error)
      end
    end

    context 'when there is no error' do
      before { allow(subject).to receive(:error).and_return nil }

      it 'does nothing' do
        expect{ subject.assert_ok! }.to_not raise_error
      end
    end
  end
end