object Service1: TService1
  DisplayName = 'Service1'
  Height = 480
  Width = 640
  object TimerTask: TTimer
    OnTimer = TimerTaskTimer
    Left = 245
    Top = 24
  end
  object TimerStack: TTimer
    Interval = 2000
    OnTimer = TimerStackTimer
    Left = 341
    Top = 23
  end
end
