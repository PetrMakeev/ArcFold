object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object ADOConn: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Pr' +
      'ojects\ArcFold\arcFold.mdb;Mode=Share Deny None;Persist Security' +
      ' Info=False;Jet OLEDB:System database="";Jet OLEDB:Registry Path' +
      '="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet O' +
      'LEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2' +
      ';Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Pas' +
      'sword="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encryp' +
      't Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Je' +
      't OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 8
  end
  object dbSetting: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    AfterScroll = dbSettingAfterScroll
    OnCalcFields = dbSettingCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from Task')
    Left = 40
    Top = 80
    object dbSettingKeyStr: TAutoIncField
      FieldName = 'KeyStr'
      ReadOnly = True
    end
    object dbSettingID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object dbSettingNameTask: TWideStringField
      FieldName = 'NameTask'
      Size = 200
    end
    object dbSettingFromZip: TWideStringField
      FieldName = 'FromZip'
      Size = 255
    end
    object dbSettingToZip: TWideStringField
      FieldName = 'ToZip'
      Size = 255
    end
    object dbSettingPrefixName: TWideStringField
      FieldName = 'PrefixName'
      Size = 255
    end
    object dbSettingFormatZip: TSmallintField
      FieldName = 'FormatZip'
    end
    object dbSettingCompressZip: TSmallintField
      FieldName = 'CompressZip'
    end
    object dbSettingCryptZip: TSmallintField
      FieldName = 'CryptZip'
    end
    object dbSettingCryptWord: TWideStringField
      FieldName = 'CryptWord'
      Size = 50
    end
    object dbSettingCryptFileName: TSmallintField
      FieldName = 'CryptFileName'
    end
    object dbSettingTipTask: TSmallintField
      FieldName = 'TipTask'
    end
    object dbSettingTimeTask: TDateTimeField
      FieldName = 'TimeTask'
    end
    object dbSettingDayMonthTask: TSmallintField
      FieldName = 'DayMonthTask'
    end
    object dbSettingOnTask: TSmallintField
      FieldName = 'OnTask'
    end
    object dbSettingSelDay: TWideStringField
      FieldName = 'SelDay'
      Size = 7
    end
    object dbSettingSelMonth: TWideStringField
      FieldName = 'SelMonth'
      Size = 12
    end
    object dbSettingLogTask: TWideMemoField
      FieldName = 'LogTask'
      BlobType = ftWideMemo
    end
    object dbSettingNextStart: TDateTimeField
      FieldName = 'NextStart'
    end
    object dbSettingLastStart: TWideStringField
      FieldName = 'LastStart'
      Size = 255
    end
    object dbSettingNextStartStr: TWideStringField
      FieldName = 'NextStartStr'
      Size = 255
    end
    object dbSettingkolCopy: TSmallintField
      FieldName = 'kolCopy'
    end
    object dbSettingOnTaskV: TStringField
      FieldKind = fkCalculated
      FieldName = 'OnTaskV'
      Calculated = True
    end
  end
  object dsSetting: TDataSource
    DataSet = dbSetting
    Left = 112
    Top = 80
  end
  object setOnTask: TADOCommand
    CommandText = 'update Task'#13#10'set onTask=:OnTask'#13#10'where ID=:ID'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'OnTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 176
    Top = 144
  end
  object addTask: TADOCommand
    CommandText = 
      'insert into Task '#13#10'( ID,'#13#10'  NAmeTask,'#13#10'  FromZip,'#13#10'  ToZip,'#13#10'  P' +
      'refixName,'#13#10'  FormatZip,'#13#10'  CompressZip,'#13#10'  CryptZip,'#13#10'  CryptWo' +
      'rd,'#13#10'  CryptFileName,'#13#10'  TipTask,'#13#10'  TimeTask,'#13#10'  DayMonthTask,'#13 +
      #10'  OnTask,'#13#10'  SelDay,'#13#10'  SelMonth,'#13#10'  LogTask,'#13#10'  NextStart,'#13#10'  ' +
      'LastStart,'#13#10'  NextStartStr,'#13#10'  KolCopy)'#13#10'values '#13#10'( :ID,'#13#10'  :Nam' +
      'eTask,'#13#10'  :FromZip,'#13#10'  :ToZip,'#13#10'  :PrefixName,'#13#10'  :FormatZip,'#13#10' ' +
      ' :CompressZip,'#13#10'  :CryptZip,'#13#10'  :CryptWord,'#13#10'  :CryptFileName,'#13#10 +
      '  :TipTask,'#13#10'  :TimeTask,'#13#10'  :DayMonthTask,'#13#10'  :OnTask,'#13#10'  :SelD' +
      'ay,'#13#10'  :SelMonth,'#13#10'  :LogTask,'#13#10'  :NextStart,'#13#10'  :LastStart,'#13#10'  ' +
      ':NextStartStr,'#13#10'  :kolCopy)'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NameTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FromZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ToZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'PrefixName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FormatZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CompressZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CryptZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CryptWord'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CryptFileName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'TipTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'TimeTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'DayMonthTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OnTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'SelDay'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'SelMonth'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'LogTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NextStart'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'LastStart'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NextStartStr'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'kolCopy'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 40
    Top = 144
  end
  object upTask: TADOCommand
    CommandText = 
      'update Task set'#13#10'  NameTask = :NameTask,'#13#10'  FromZip = :FromZip,'#13 +
      #10'  ToZip = :ToZip,'#13#10'  PrefixName =:PrefixName,'#13#10'  FormatZip = :F' +
      'ormatZip,'#13#10'  CompressZip = :CompressZip,'#13#10'  CryptZip = :CryptZip' +
      ','#13#10'  CryptWord = :CryptWord,'#13#10'  CryptFileName = :CryptFileName,'#13 +
      #10'  TipTask = :TipTask,'#13#10'  TimeTask = :TimeTask,'#13#10'  DayMonthTask ' +
      '= :DayMonthTask,'#13#10'  OnTask = :OnTask,'#13#10'  SelDay = :SelDay,'#13#10'  Se' +
      'lMonth = :SelMonth,'#13#10'  LogTask = :LogTask,'#13#10'  NextStart = :NextS' +
      'tart,'#13#10'  LastStart = :LastStart,'#13#10'  NextStartStr = :NextStartStr' +
      ','#13#10'  KolCopy = :KolCopy'#13#10'where id=:id'#13#10#13#10
    Connection = ADOConn
    Parameters = <
      item
        Name = 'NameTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FromZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ToZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'PrefixName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FormatZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CompressZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CryptZip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CryptWord'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'CryptFileName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'TipTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'TimeTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'DayMonthTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'OnTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'SelDay'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'SelMonth'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'LogTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NextStart'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'LastStart'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NextStartStr'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'kolCopy'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 104
    Top = 144
  end
  object setLastStartTask: TADOCommand
    CommandText = 'update Task'#13#10'set LastStart=:LastStart'#13#10'where ID=:ID'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'LastStart'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 256
    Top = 144
  end
  object dbFindTask: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      'Task.ID, Task.NameTask, Task.NextStart, '
      'TipTask, TimeTask, SelDay, SelMonth, DayMonthTask'
      'FROM Task'
      'WHERE ( DateAdd('#39's'#39', -2, Now()) <= Task.NextStart ) and'
      
        '             ( Task.NextStart <= DateAdd('#39's'#39', -1, Now() ) ) and ' +
        'Task.onTask=1')
    Left = 224
    Top = 80
    object dbFindTaskID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object dbFindTaskNameTask: TWideStringField
      FieldName = 'NameTask'
      Size = 200
    end
    object dbFindTaskNextStart: TDateTimeField
      FieldName = 'NextStart'
    end
    object dbFindTaskTipTask: TSmallintField
      FieldName = 'TipTask'
    end
    object dbFindTaskTimeTask: TDateTimeField
      FieldName = 'TimeTask'
    end
    object dbFindTaskSelDay: TWideStringField
      FieldName = 'SelDay'
      Size = 7
    end
    object dbFindTaskSelMonth: TWideStringField
      FieldName = 'SelMonth'
      Size = 12
    end
    object dbFindTaskDayMonthTask: TSmallintField
      FieldName = 'DayMonthTask'
    end
  end
  object qStartTask: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM Task '
      'WHERE ID=:ID')
    Left = 304
    Top = 80
    object qStartTaskKeyStr: TAutoIncField
      FieldName = 'KeyStr'
      ReadOnly = True
    end
    object qStartTaskID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object qStartTaskNameTask: TWideStringField
      FieldName = 'NameTask'
      Size = 200
    end
    object qStartTaskFromZip: TWideStringField
      FieldName = 'FromZip'
      Size = 255
    end
    object qStartTaskToZip: TWideStringField
      FieldName = 'ToZip'
      Size = 255
    end
    object qStartTaskPrefixName: TWideStringField
      FieldName = 'PrefixName'
      Size = 255
    end
    object qStartTaskFormatZip: TSmallintField
      FieldName = 'FormatZip'
    end
    object qStartTaskCompressZip: TSmallintField
      FieldName = 'CompressZip'
    end
    object qStartTaskCryptZip: TSmallintField
      FieldName = 'CryptZip'
    end
    object qStartTaskCryptWord: TWideStringField
      FieldName = 'CryptWord'
      Size = 50
    end
    object qStartTaskCryptFileName: TSmallintField
      FieldName = 'CryptFileName'
    end
    object qStartTaskTipTask: TSmallintField
      FieldName = 'TipTask'
    end
    object qStartTaskTimeTask: TDateTimeField
      FieldName = 'TimeTask'
    end
    object qStartTaskDayMonthTask: TSmallintField
      FieldName = 'DayMonthTask'
    end
    object qStartTaskOnTask: TSmallintField
      FieldName = 'OnTask'
    end
    object qStartTaskSelDay: TWideStringField
      FieldName = 'SelDay'
      Size = 7
    end
    object qStartTaskSelMonth: TWideStringField
      FieldName = 'SelMonth'
      Size = 12
    end
    object qStartTaskLogTask: TWideMemoField
      FieldName = 'LogTask'
      BlobType = ftWideMemo
    end
    object qStartTaskNextStart: TDateTimeField
      FieldName = 'NextStart'
    end
    object qStartTaskLastStart: TWideStringField
      FieldName = 'LastStart'
      Size = 255
    end
    object qStartTaskNextStartStr: TWideStringField
      FieldName = 'NextStartStr'
      Size = 255
    end
    object qStartTaskkolCopy: TSmallintField
      FieldName = 'kolCopy'
    end
  end
  object dbStack: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    OnCalcFields = dbStackCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from stack')
    Left = 40
    Top = 256
    object dbStackKeyStr: TAutoIncField
      FieldName = 'KeyStr'
      ReadOnly = True
    end
    object dbStackID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object dbStackNameTask: TWideStringField
      FieldName = 'NameTask'
      Size = 255
    end
    object dbStackStartTime: TDateTimeField
      FieldName = 'StartTime'
    end
    object dbStackonExec: TSmallintField
      FieldName = 'onExec'
    end
    object dbStackOnExecV: TStringField
      FieldKind = fkCalculated
      FieldName = 'OnExecV'
      Calculated = True
    end
  end
  object dsStack: TDataSource
    DataSet = dbStack
    Left = 104
    Top = 256
  end
  object dbFindStack: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT Stack.ID, Stack.NameTask, Stack.StartTime, Stack.onExec'
      'FROM Stack '
      '')
    Left = 224
    Top = 256
    object dbFindStackID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object dbFindStackNameTask: TWideStringField
      FieldName = 'NameTask'
      Size = 255
    end
    object dbFindStackStartTime: TDateTimeField
      FieldName = 'StartTime'
    end
    object dbFindStackonExec: TSmallintField
      FieldName = 'onExec'
    end
  end
  object existStack: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from stack')
    Left = 304
    Top = 256
    object existStackKeyStr: TAutoIncField
      FieldName = 'KeyStr'
      ReadOnly = True
    end
    object existStackID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object existStackNameTask: TWideStringField
      FieldName = 'NameTask'
      Size = 255
    end
    object existStackStartTime: TDateTimeField
      FieldName = 'StartTime'
    end
    object existStackonExec: TSmallintField
      FieldName = 'onExec'
    end
  end
  object addExecTask: TADOCommand
    CommandText = 
      'insert into Stack (ID, NameTask, onExec, StartTime) Values (:ID,' +
      ' :NameTask, :onExec, :StartTime)'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NameTask'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'onExec'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'StartTime'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 40
    Top = 344
  end
  object setExecStack: TADOCommand
    CommandText = 'update stack '#13#10'set onExec=:OnExec '#13#10'where ID=:ID'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'OnExec'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 288
    Top = 344
  end
  object clearStack: TADOCommand
    CommandText = 'delete from stack where 1=1'
    Connection = ADOConn
    Parameters = <>
    Left = 208
    Top = 344
  end
  object delExecStack: TADOCommand
    CommandText = 'delete from stack where ID=:ID'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 120
    Top = 344
  end
  object setNextStartTask: TADOCommand
    CommandText = 
      'update Task'#13#10'set NextStart=:NextStart,'#13#10'     NextStartStr = :Nex' +
      'tStartStr'#13#10'where ID=:ID'
    Connection = ADOConn
    Parameters = <
      item
        Name = 'NextStart'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'NextStartStr'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 368
    Top = 144
  end
  object qTask: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    OnCalcFields = dbSettingCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from Task')
    Left = 472
    Top = 80
    object qTaskTipTask: TSmallintField
      FieldName = 'TipTask'
    end
    object qTaskTimeTask: TDateTimeField
      FieldName = 'TimeTask'
    end
    object qTaskDayMonthTask: TSmallintField
      FieldName = 'DayMonthTask'
    end
    object qTaskSelDay: TWideStringField
      FieldName = 'SelDay'
      Size = 7
    end
    object qTaskSelMonth: TWideStringField
      FieldName = 'SelMonth'
      Size = 12
    end
    object qTaskID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
  end
end
