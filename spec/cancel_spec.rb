# spec/string_calculator_spec.rb
#describe Cancel do
#end
require 'impala'

describe "Testing asynchronous queries - Dev tests TO BE REMOVED" do

  context "checks Cancel" do
  
    it "Trying to query 1" do
      conn = Impala.connect('localhost', 21000)
      ret = conn.query('select "test1", gds from nh_ti_vistana_v1_5_p35_od1.booking_ond_activity_v12_partial Limit 10', asynchronous: false)
      conn.close
      puts ret
    end
    
    it "Trying to query 2" do
      conn = Impala.connect('localhost', 21000)
      ret = conn.query('select "test2", gds from nh_ti_vistana_v1_5_p35_od1.booking_ond_activity_v12_partial Limit 19', asynchronous: true)
      conn.close
      puts ret
    end
    
    it "Trying to query 3" do
      conn = Impala.connect('localhost', 21000)
      a = Thread.new{
      ret = conn.query('select sum(pax_delta),gds, agency_name from nh_ti_vistana_v1_5_p35_od1.booking_ond_activity_v12_partial group by gds, agency_name order by agency_name', asynchronous: true)
      }
      sleep 5
      conn.close
      sleep 50
    end

    it "Trying to query 4" do
      10.times do |i|
        conn = Impala.connect('localhost', 21000)
        a = Thread.new{
        ret = conn.query("select \"thrift_test query#{i}\", sum(pax_delta),gds, agency_name from nh_ti_vistana_v1_5_p35_od1.booking_ond_activity_v12_partial group by gds, agency_name order by agency_name", asynchronous: true)
        }
        sleep 5
        conn.close
        sleep 5
      end
    end
    
  end
  
end