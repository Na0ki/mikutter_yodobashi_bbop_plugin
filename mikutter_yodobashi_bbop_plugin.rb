#-*- coding: utf-8 -*-

Plugin.create :yodobashibbop do

  @elements = ['ヨォ', 'ドォ', 'バァ', 'シィ', 'カァ', 'メェ', 'ラ']

  # ydop実行(def ydop yodobashibbop)
  def yodobashibbop
    result = @elements.size.times.map { @elements.sample }
    score = getscore(result)

    "#{result.join} (#{sprintf('%.1f', score*100)}\%)"
  end

  # スコア計算
  def getscore(str)
    str.zip(@elements).select { |a, b| a == b }.size / @elements.size.to_f
  end

  on_appear do |ms|
    ms.each do |m|
      if Time.now - m[:created] > 5
        next
      end
      if m.message.to_s =~ /^@#{Service.primary.user.to_s} (yodobashi|ヨドバシ)/
        puts 'passed if'
        # Plugin.activity :system, "#{yodobashibbop}"
        m.message.post(:message => "@#{m.message.user[:idname]} #{yodobashibbop}")
      end
    end
  end
end
