module Craftar
  class Image < Craftar::Base
    attr_reader :uuid, :item, :resource_uri, :file, :name, :status, :thumb_120, :thumb_60, :tracking_data_status, :file_from_url

    def self.craftar_name
      'image'
    end

    def initialize(opts, file_from_url: false)
      @file_from_url = file_from_url
      set_attributes(opts)
    end

    def save
      if @file_from_url
        @file = prepare_file_from_url(@file)
      end
      
      response = call(:post, file: @file, item: item)
      set_attributes(response)
      self
    end

    private

    def set_attributes(opts)
      @uuid = opts['uuid'] || opts[:uuid]
      @item = opts['item'] || opts[:item]
      @file = opts['file'] || opts[:file]
      @resource_uri = opts['resource_uri'] || opts[:resource_uri]
      @name = opts['name'] || opts[:name]
      @status = opts['status'] || opts[:status]
      @thumb_120 = opts['thumb_120'] || opts[:thumb_120]
      @thumb_60 = opts['thumb_60'] || opts[:thumb_60]
      @tracking_data_status = opts['tracking_data_status'] || opts[:tracking_data_status]
    end
  end
end
