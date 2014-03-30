require 'csv'
require 'rqrcode_png'

module Qrery
	class Importer

		def initialize(inputfile = nil, size = nil)
			inputfile ||= 'data.csv'
			size ||= 270

			@inputfile = inputfile
			@size = size.to_i
		end

		def gen
			export(import)
		end

		def import
			CSV.foreach(@inputfile, { headers: true }) do |row|
				output = ""
				row.each { |k,v|
					output << cleanse(v) unless v.nil?
					output << ':'
					# puts output
				}
				export(output)
			end
		end

		def cleanse(row)
			row.gsub!(/[^0-9A-Za-z]/, '')
			row.upcase!
			return row
		end

		def export(output)
			qr = RQRCode::QRCode.new(output, size: 21, level: :h)
			png = qr.to_img
			png.resize(@size,@size).save("image#{filetime}.png")
		end

		def filetime
			Time.now.strftime("%Y%m%d%H%M%S%L").to_i
		end
	end
end

