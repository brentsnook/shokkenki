require_relative '../../spec_helper'
require 'json'
require 'shokkenki/provider/ticket_reader'

describe Shokkenki::Provider::TicketReader do
  context 'reading tickets' do

    before do
      allow(Shokkenki::Provider::Model::Ticket).to receive(:from_json).with(ticket_json.to_json).and_return ticket
      allow(Shokkenki::Provider::Model::Ticket).to receive(:from_hash).with(ticket_json).and_return ticket
    end

    let(:ticket_json) { {'ticket' => 'json'} }
    let(:tickets_json) { [ticket_json] }
    let(:ticket) { double 'ticket' }

    context 'when the given location is callable' do

      let(:proc) { lambda { [ticket] } }

      it 'calls the location to return a collection of tickets' do
        expect(subject.read_from(proc)).to eq([ticket])
      end

    end

    context 'when the given location is a directory' do
      before do
        allow(Dir).to receive(:exists?).with('directory').and_return(true)
        allow(Dir).to receive(:glob).with('directory/**/*.json').and_return(['file'])
        allow(File).to receive(:read).with('file').and_return ticket_json.to_json
      end

      it 'parses all files in the location that end with .json' do
        expect(subject.read_from('directory')).to eq([ticket])
      end
    end

    context 'when the given location is a file' do
      before do
        allow(Dir).to receive(:exists?).with('file').and_return(false)
        allow(File).to receive(:read).with('file').and_return ticket_json.to_json
      end

      it 'parses the contents of the file as JSON' do
        expect(subject.read_from('file')).to eq([ticket])
      end
    end

    context 'when the given location is a URI' do

      let(:resource) { double('resource', :read => "[#{ticket_json.to_json}]")}
      before do
        allow(subject).to receive(:open).with('http://tickets.com') do |&block|
          block.call resource
        end
      end

      it 'reads the location to return a JSON array of tickets and parses them' do
        expect(subject.read_from('http://tickets.com')).to eq([ticket])
      end

    end
  end
end