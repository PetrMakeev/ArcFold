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

//Определяем дату и время следующего старта задачи
function FindNextStart(TipTask: integer; TimeTask: TDateTime; SelDay,
  SelMonth: string; DayMonthTask: word): TDateTime;
var
  tmpHour, tmpMinute, tmpSecond, tmpMSec: Word;
  tmpDateTime, DateTimeStart, currDateTime:TDateTime;
  currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec: Word;
  currDayWeek, currMonthYear: word;
  I: Word;
begin

  //определяем время следующего старта задачи
  DecodeTime(TimeTask, tmpHour, tmpMinute, tmpSecond, tmpMSec);

  //фиксируем текущие дату и время
  DecodeDateTime(Now(), currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);
  currDateTime := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, 0);
  DateTimeStart := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, 0);

  //ежедневно
  if TipTask=0 then
  begin
    tmpDateTime := EncodeDateTime(currYear, currMonth, currDay, tmpHour, tmpMinute, 0, 0);
    //проверяем прошло время запуска сегодня или нет
    if currDateTime > tmpDateTime then
      tmpDateTime := EncodeDateTime(currYear, CurrMonth, CurrDay + 1, tmpHour, tmpMinute, 0, 0);

    DateTimeStart := tmpDateTime;
  end;

  //Еженедельно
  if TipTask=1 then
  begin

    // определяем текущий день недели
    currDayWeek := DayOfTheWeek(Now());

    // принимаем точку поиска за дату и время позже на 14 дней
    DateTimeStart := IncDay(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 14-CurrDayWeek);

    //перебираем дни недели для определения дня старта задачи
    for I := 1 to 7 do
    begin

      // проверить есть ли на данный день недели старт задачи
      if midStr(SelDay, I, 1) = '1' then
      begin
        //формируем на день недели дату и время старта
        tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I );

        // если старт задачи  прошел то определяем его на следующую неделю
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I + 1);

        // если найденное tmpDateTime позже currDateTime и DateTimeStart раньше определенного как самое крайнее сохраняем его
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;

    end;

   end;

   //ежемесячно
   if TipTask=2 then
   begin

    // определяем текущий месяц
    currMonthYear := MonthOfTheYear(Now());

    // принимаем точку поиска за дату и время позже на 24 месяцев
    DateTimeStart := IncMonth(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 24-currMonthYear);

    // перебираем месяцы для определения дня старта задачи
    for I := 1 to 12 do
    begin
      // проверить есть ли на данный день недели старт задачи
      if midStr(SelMonth, I, 1) = '1' then
      begin

        //формируем на день недели дату и время старта
        tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 0); // -currMonthYear + I );

        // если старт задачи  прошел то определяем его на следующий месяц
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 12); //-currMonthYear + I + 12);

        // если найденное tmpDateTime позже currDateTime и DateTimeStart раньше определенного как самое крайнее сохраняем его
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

  ListLog := TStringList.Create; //Создал СтрингГрид

  if FileExists(nameLog) then
    ListLog.LoadFromFile(nameLog)
  else
    ListLog.Clear;;

  ListLog.Add(strLog ); //Если надо дописать строку в конец файла

  ListLog.SaveToFile(nameLog); //Сохранил в этот же файл
  ListLog.Free; //Убил СтрингЛист


end;



end.
