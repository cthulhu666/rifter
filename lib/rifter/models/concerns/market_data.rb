require 'open-uri'

module Rifter
  module MarketData
    extend ActiveSupport::Concern

    included do
      field :avg_sell_price, type: Float
      field :market_data_updated_at, type: DateTime

      def self.fetch_market_data(query, batch_size: 50)
        progressbar = ProgressBar.create
        progressbar.total = query.count
        query.each_slice(batch_size) do |slice|
          ids = slice.map(&:type_id).join ','
          doc = Nokogiri::HTML(open("http://api.eve-central.com/api/marketstat?typeid=#{ids}"))
          slice.each { |item| item.update_market_data(doc) }
          progressbar.progress += slice.size
        end
      end
    end

    def fetch_market_data
      doc = Nokogiri::HTML(open("http://api.eve-central.com/api/marketstat?typeid=#{type_id}"))
      update_market_data(doc)
    end

    def update_market_data(doc)
      volume = doc.xpath("//type[@id=#{type_id}]/sell/volume").text.to_i
      # stddev = doc.xpath("//type[@id=#{type_id}]/sell/stddev").text.to_f
      avg = doc.xpath("//type[@id=#{type_id}]/sell/avg").text.to_f
      if volume > 100
        update_attributes(
          avg_sell_price: avg,
          market_data_updated_at: DateTime.now
        )
      else
        update_attributes(
          avg_sell_price: nil,
          market_data_updated_at: DateTime.now
        )
      end
    end
  end
end
