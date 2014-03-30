require 'csv'

module Qrery
	class Importer

		def initialize(inputfile = nil, outputfile = nil)
			inputfile ||= 'data.csv'
			outputfile ||= 'image'

			@inputfile = inputfile
			@outputfile = outputfile
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
					puts output
				}
			end
		end

		def cleanse(row)
			row.gsub!(/[^0-9A-Za-z]/, '')
			row.upcase!
			return row
		end

		def export
		end
	end
end

