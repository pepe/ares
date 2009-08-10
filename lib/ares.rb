require 'net/http'
require 'crack/xml'

class Ares
  SERVICE_URL = "http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_std.cgi?%s".freeze
  attr_reader :options, :result

  # class methods
  class << self
    # finds subject by any part on ares service
    def find(options)
      return new(options)
    end
  end

  # initializes new ares object 
  def initialize(options)
    @options = options
    @result = Crack::XML.parse(Net::HTTP.get(URI.parse(SERVICE_URL % self.params)))
    return self
  end

  # returns true if subject found on ares, otherwise false
  def found?
    @found ||= !(self.result["are:Ares_odpovedi"]["are:Odpoved"]["are:Pocet_zaznamu"] == '0' ||
      self.result["are:Ares_odpovedi"]["are:Odpoved"]["are:Error"])
  end

  # returns params like concatenated options
  def params
    @params ||= options.inject([]) do |res, pair|
       res << "%s=%s" % [pair.first, pair.last]
    end.join('&')
  end

  # returns just answer part
  def answer
    @answer ||= self.result["are:Ares_odpovedi"]["are:Odpoved"]["are:Zaznam"]
  end

  # returns company name
  def company_name
    @company_name ||= self.answer["are:Obchodni_firma"]
  end

  # returns ico
  def ico
    @company_name ||= self.answer["are:ICO"]
  end

  # returns subject type
  def subject_type
    @subject_type ||= if self.answer["are:Identifikace"]["are:Osoba"].nil?
                        "P"
                      end
  end

  # returns address
  def address
    unless @address 
      @address = {
      :city => self.raw_address['dtt:PSC'][0..0] == "1" ? self.raw_address['dtt:Nazev_mestske_casti'] : self.raw_address['dtt:Nazev_obce'],
      :street => [self.raw_address["dtt:Nazev_ulice"], [self.raw_address['dtt:Cislo_domovni'], self.raw_address['dtt:Cislo_orientacni']].compact.join('/')].join(' '),
      :zip => self.raw_address['dtt:PSC']
    }
      @address[:country] = "Česká republika" if self.raw_address['dtt:Kod_statu'].to_i == 203
    end
    return @address
  end

  # returns raw address
  def raw_address
    @raw_address ||= if self.subject_type == "P"
                   self.answer["are:Identifikace"]["are:Adresa_ARES"]
                 end
  end
end
