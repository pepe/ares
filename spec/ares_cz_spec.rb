require 'rubygems'
require 'rspec'
require 'lib/ares_cz'

SERVICE_URL = "http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_std.cgi?%s".freeze
describe "ares" do
  # mocks net/http to return gravastar result
  def mock_found
    @test_xml = <<TEST_XML
      <?xml version="1.0" encoding="UTF-8"?>
      <are:Ares_odpovedi xmlns:are="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_answer/v_1.0.1" xmlns:dtt="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_datatypes/v_1.0.4" xmlns:udt="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/uvis_datatypes/v_1.0.1" odpoved_datum_cas="2009-08-07T10:55:41" odpoved_pocet="1" odpoved_typ="Standard" vystup_format="XML" xslt="klient" validation_XSLT="/ares/xml_doc/schemas/ares/ares_answer/v_1.0.0/ares_answer.xsl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_answer/v_1.0.1 http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_answer/v_1.0.1/ares_answer_v_1.0.1.xsd" Id="ares">
      <are:Odpoved>
      <are:Pocet_zaznamu>1</are:Pocet_zaznamu>
      <are:Typ_vyhledani>FREE</are:Typ_vyhledani>
      <are:Zaznam>
      <are:Shoda_ICO>
      <dtt:Kod>9</dtt:Kod>
      </are:Shoda_ICO>
      <are:Vyhledano_dle>ICO</are:Vyhledano_dle>
      <are:Typ_registru>
      <dtt:Kod>2</dtt:Kod>

      <dtt:Text>OR</dtt:Text>
      </are:Typ_registru>
      <are:Datum_vzniku>2005-11-03</are:Datum_vzniku>
      <are:Datum_platnosti>2009-08-07</are:Datum_platnosti>
      <are:Pravni_forma>
      <dtt:Kod_PF>112</dtt:Kod_PF>
      </are:Pravni_forma>
      <are:Obchodni_firma>GravaStar s.r.o.</are:Obchodni_firma>
      <are:ICO>27386830</are:ICO>
      <are:Identifikace>
      <are:Adresa_ARES>

      <dtt:ID_adresy>202396372</dtt:ID_adresy>
      <dtt:Kod_statu>203</dtt:Kod_statu>
      <dtt:Nazev_okresu>Hlavní město Praha</dtt:Nazev_okresu>
      <dtt:Nazev_obce>Praha</dtt:Nazev_obce>
      <dtt:Nazev_casti_obce>Bubeneč</dtt:Nazev_casti_obce>
      <dtt:Nazev_mestske_casti>Praha 6</dtt:Nazev_mestske_casti>
      <dtt:Nazev_ulice>Charlese de Gaulla</dtt:Nazev_ulice>
      <dtt:Cislo_domovni>800</dtt:Cislo_domovni>
      <dtt:Cislo_orientacni>3</dtt:Cislo_orientacni>

      <dtt:PSC>16000</dtt:PSC>
      <dtt:Adresa_UIR>
      <udt:Kod_oblasti>19</udt:Kod_oblasti>
      <udt:Kod_kraje>19</udt:Kod_kraje>
      <udt:Kod_okresu>3100</udt:Kod_okresu>
      <udt:Kod_obce>554782</udt:Kod_obce>
      <udt:Kod_pobvod>60</udt:Kod_pobvod>
      <udt:Kod_sobvod>60</udt:Kod_sobvod>
      <udt:Kod_casti_obce>490024</udt:Kod_casti_obce>

      <udt:Kod_mestske_casti>500178</udt:Kod_mestske_casti>
      <udt:PSC>16000</udt:PSC>
      <udt:Kod_ulice>470813</udt:Kod_ulice>
      <udt:Cislo_domovni>800</udt:Cislo_domovni>
      <udt:Typ_cislo_domovni>1</udt:Typ_cislo_domovni>
      <udt:Cislo_orientacni>3</udt:Cislo_orientacni>
      <udt:Kod_adresy>22182616</udt:Kod_adresy>
      <udt:Kod_objektu>22099042</udt:Kod_objektu>
      <udt:PCD>2495506</udt:PCD>

      </dtt:Adresa_UIR>
      </are:Adresa_ARES>
      </are:Identifikace>
      <are:Kod_FU>6</are:Kod_FU>
      <are:Priznaky_subjektu>NAAANANNNNNNNNNNNNNNNNNNNNNNNN</are:Priznaky_subjektu>
      </are:Zaznam>
      </are:Odpoved>
      </are:Ares_odpovedi>
TEST_XML
    Net::HTTP.stub!(:get).and_return(@test_xml)
  end

  # mocks net/http to return empty result
  def mock_not_found
    @test_xml = <<TEST_XML
      <?xml version="1.0" encoding="UTF-8"?>
      <are:Ares_odpovedi xmlns:are="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_answer/v_1.0.1" xmlns:dtt="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_datatypes/v_1.0.4" xmlns:udt="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/uvis_datatypes/v_1.0.1" odpoved_datum_cas="2009-08-07T10:49:40" odpoved_pocet="1" odpoved_typ="Standard" vystup_format="XML" xslt="klient" validation_XSLT="/ares/xml_doc/schemas/ares/ares_answer/v_1.0.0/ares_answer.xsl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_answer/v_1.0.1 http://wwwinfo.mfcr.cz/ares/xml_doc/schemas/ares/ares_answer/v_1.0.1/ares_answer_v_1.0.1.xsd" Id="ares">
      <are:Odpoved>
      <are:Pocet_zaznamu>0</are:Pocet_zaznamu>
      <are:Typ_vyhledani>FREE</are:Typ_vyhledani>
      </are:Odpoved>
      </are:Ares_odpovedi>
TEST_XML
    Net::HTTP.should_receive(:get).at_least(:once).and_return(@test_xml)
  end

  describe "initialization and basic methods" do
    before(:each) do
      mock_not_found
    end

    it "should be created by finder" do
      mock_found
      ares = Ares.find(:ico => '666')
      ares.should_not be_nil
      ares.class.should == Ares
    end

    it "should store options" do
      mock_found
      ares = Ares.find(:ico => '666')
      ares.options.should == {"ico" => '666'}
    end

    it "should have params with equal sign concatenated options" do
      mock_found
      ares = Ares.find(:ico => '27386830')
      ares.params.should == "ico=27386830" 
      ares = Ares.find(:ico => '27386830', :obchodni_firma => 'Grava')
      ares.params.should == "ico=27386830&obchodni_firma=Grava" 
      ares = Ares.find(:ico => '27386 830')
      ares.params.should == "ico=27386830" 
    end

    it "should have result with hash from xml" do
      ares = Ares.find(:ico => '27386830')
      ares.result.class.should == Hash
    end
  end

  describe "founding" do
    it "should not find not existing subject on ares" do
      mock_not_found
      ares = Ares.find(:ico => '666')
      ares.found?.should be_false
    end

    it "should find existing subject on ares" do
      mock_found
      ares = Ares.find(:ico => '27386830')
      ares.found?.should be_true
    end

    it "should not find when there is ico with not suitable chars" do
      mock_not_found
      ares = Ares.find(:ico => '27386$830')
      ares.found?.should be_false
    end

    it "should find when there is ico with spaces in it" do
      mock_not_found
      ares = Ares.find(:ico => '27386$830')
      ares.found?.should be_false
    end
  end

  describe "parser" do
    it "should parse company_name" do
      mock_found
      ares = Ares.find(:ico => '27386830')
      ares.company_name.should == "GravaStar s.r.o."
    end

    it "should parse ico" do
      mock_found
      ares = Ares.find(:ico => '27386830')
      ares.ico.should == '27386830'
    end

    it "should parse subject type" do
      mock_found
      ares = Ares.find(:ico => '27386830')
      ares.subject_type.should == 'P'
    end

    it "should parse address" do
      mock_found
      ares = Ares.find(:ico => '27386830')
      ares.address.is_a?(Hash).should be_true
      ares.address.should == {
        :city => "Praha 6",
        :street => "Charlese de Gaulla 800/3",
        :street_name => "Charlese de Gaulla",
        :building_number => "800/3",
        :zip => '16000',
        :country => "Česká republika"
      }
    end
  end
end

