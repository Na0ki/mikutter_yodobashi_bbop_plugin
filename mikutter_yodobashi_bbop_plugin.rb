# -*- coding: utf-8 -*-
# -*- frozen_string_literal: true -*-

Plugin.create :yodobashibbop do
  @elements = %w[ヨォ ドォ バァ シィ カァ メェ ラ]

  # ydop実行(def ydop yodobashibbop)
  def yodobashi_bbop
    # 並べ替え
    result = Array.new(@elements.size) { @elements.sample }
    # スコア計算
    score  = result.zip(@elements).select { |a, b| a == b }.size / @elements.size.to_f

    "#{result.join} (%.1f%%)" % (score * 100)
  end

  on_appear do |ms|
    ms.each do |m|
      next if Time.now - m[:created] > 5

      if m.to_s =~ /^@#{Service.primary.user.to_s} (yodobashi|ヨドバシ)/
        m.post(message: "@#{m.user[:idname]} #{yodobashi_bbop}")
      end
    end
  end
end
