#-*- coding: utf-8 -*-
 
@@elements = ["ヨォ","ドォ","バァ","シィ","カァ","メェ","ラ"]
 
def yodobashibbop()
  result = @@elements.size.times.map{@@elements.sample}
  score = getscore(result)
  
  return "#{result.join} (#{sprintf("%.1f",score*100)}\%)"
end

def getscore(str)
  str.zip(@@elements).select{ |a,b| a==b}.size / @@elements.size.to_f
end

Plugin.create :yodobashibbop do
  on_appear do |ms|
    ms.each do |m|
      if Time.now - m[:created] > 5
        next
      end
      if m.message.to_s =~ /^@#{Service.primary.user.to_s} yodobashi/
        m.favorite
        # Plugin.activity :system, "#{yodobashibbop}"
        m.message.post(:message => "@#{m.message.user[:idname]} #{yodobashibbop}")
      end
    end
  end
end