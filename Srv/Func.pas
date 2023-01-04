unit Func;

interface

uses
  system.SysUtils, System.DateUtils, system.StrUtils, Classes ;

 function FindNextStart(TipTask:integer;
                        TimeTask:TDateTime;
                        SelDay:string;
                        SelMonth:string;
                        DayMonthTask:word
                        ):TDateTime;



  procedure logZip(pathLog, nameLog, strLog:string);

implementation

uses
  ArcFoldSrv, UnitDMSrv;

//���������� ���� � ����� ���������� ������ ������
function FindNextStart(TipTask: integer; TimeTask: TDateTime; SelDay,
  SelMonth: string; DayMonthTask: word): TDateTime;
var
  tmpHour, tmpMinute, tmpSecond, tmpMSec: Word;
  tmpDateTime, DateTimeStart, currDateTime:TDateTime;
  currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec: Word;
  currDayWeek, currMonthYear: word;
  I: Word;
begin

  //���������� ����� ���������� ������ ������
  DecodeTime(TimeTask, tmpHour, tmpMinute, tmpSecond, tmpMSec);

  //��������� ������� ���� � �����
  DecodeDateTime(Now(), currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);
  currDateTime := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, 0);
  DateTimeStart := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, 0);

  //���������
  if TipTask=0 then
  begin
    tmpDateTime := EncodeDateTime(currYear, currMonth, currDay, tmpHour, tmpMinute, 0, 0);
    //��������� ������ ����� ������� ������� ��� ���
    if currDateTime > tmpDateTime then
      tmpDateTime := EncodeDateTime(currYear, CurrMonth, CurrDay + 1, tmpHour, tmpMinute, 0, 0);

    DateTimeStart := tmpDateTime;
  end;

  //�����������
  if TipTask=1 then
  begin

    // ���������� ������� ���� ������
    currDayWeek := DayOfTheWeek(Now());

    // ��������� ����� ������ �� ���� � ����� ����� �� 14 ����
    DateTimeStart := IncDay(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 14-CurrDayWeek);

    //���������� ��� ������ ��� ����������� ��� ������ ������
    for I := 1 to 7 do
    begin

      // ��������� ���� �� �� ������ ���� ������ ����� ������
      if midStr(SelDay, I, 1) = '1' then
      begin
        //��������� �� ���� ������ ���� � ����� ������
        tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I );

        // ���� ����� ������  ������ �� ���������� ��� �� ��������� ������
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I + 1);

        // ���� ��������� tmpDateTime ����� currDateTime � DateTimeStart ������ ������������� ��� ����� ������� ��������� ���
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;

    end;

   end;

   //����������
   if TipTask=2 then
   begin

    // ���������� ������� �����
    currMonthYear := MonthOfTheYear(Now());

    // ��������� ����� ������ �� ���� � ����� ����� �� 24 �������
    DateTimeStart := IncMonth(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 24-currMonthYear);

    // ���������� ������ ��� ����������� ��� ������ ������
    for I := 1 to 12 do
    begin
      // ��������� ���� �� �� ������ ���� ������ ����� ������
      if midStr(SelMonth, I, 1) = '1' then
      begin

        //��������� �� ���� ������ ���� � ����� ������
        tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 0); // -currMonthYear + I );

        // ���� ����� ������  ������ �� ���������� ��� �� ��������� �����
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 12); //-currMonthYear + I + 12);

        // ���� ��������� tmpDateTime ����� currDateTime � DateTimeStart ������ ������������� ��� ����� ������� ��������� ���
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;
    end;

   end;


  Result := DateTimeStart;

end;



procedure logZip(pathLog, nameLog, strLog: string);
var
  ListLog : TStringList;

begin

  if not DirectoryExists(pathLog) then CreateDir(pathLog);

  ListLog := TStringList.Create; //������ ����������

  if FileExists(nameLog) then
    ListLog.LoadFromFile(nameLog)
  else
    ListLog.Clear;;

  ListLog.Add(strLog ); //���� ���� �������� ������ � ����� �����

  ListLog.SaveToFile(nameLog); //�������� � ���� �� ����
  ListLog.Free; //���� ����������


end;



end.
