unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Vcl.AppEvnts, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.DBCtrls, System.StrUtils, Vcl.ComCtrls,
  System.DateUtils;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    TrayIcon: TTrayIcon;
    popTray: TPopupMenu;
    popRestore: TMenuItem;
    AppEvents: TApplicationEvents;
    dbSetting: TClientDataSet;
    dbSettingFromZip: TStringField;
    dbSettingToZip: TStringField;
    dbSettingNameTask: TStringField;
    dbSettingPrefixName: TStringField;
    dbSettingFormatZip: TIntegerField;
    dbSettingCompressZip: TIntegerField;
    dbSettingCryptWord: TStringField;
    dbSettingCryptFileName: TIntegerField;
    dbSettingTipTask: TIntegerField;
    dbSettingTimeTask: TDateTimeField;
    dbSettingDayMonthTask: TIntegerField;
    dsSetting: TDataSource;
    Button1: TButton;
    popTask: TPopupMenu;
    popAdd: TMenuItem;
    popOn: TMenuItem;
    popDel: TMenuItem;
    popOff: TMenuItem;
    dbSettingOnTask: TIntegerField;
    dbSettingCryptZip: TIntegerField;
    popEdit: TMenuItem;
    N1: TMenuItem;
    dbSettingSelDay: TStringField;
    dbSettingSelMonth: TStringField;
    dbSettingNameTaskV: TStringField;
    dbSettingOnTaskV: TStringField;
    pgTask: TPageControl;
    tabTask: TTabSheet;
    DBGrid1: TDBGrid;
    tabStack: TTabSheet;
    memLog: TMemo;
    Label1: TLabel;
    dbSettingLogTask: TMemoField;
    dbStack: TClientDataSet;
    dbSettingID: TStringField;
    dbStackID: TStringField;
    dbStackNameTask: TStringField;
    dbStackStartTime: TDateTimeField;
    DBGrid2: TDBGrid;
    dsStack: TDataSource;
    dbStackOnExec: TStringField;
    dbSettingNextStart: TDateTimeField;
    dbSettingLastStartV: TStringField;
    dbSettingNextStartStr: TStringField;
    procedure popRestoreClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure popTaskPopup(Sender: TObject);
    procedure popAddClick(Sender: TObject);

    procedure AddSetting();  // тестовая процедура


    function FindNextStart(TipTask:integer;
                          TimeTask:TDateTime;
                          SelDay:string;
                          SelMonth:string;
                          DayMonthTask:integer
                          ):TDateTime;
    procedure SaveSetting(NameTask:string;
                       FromZip:string;
                       ToZip:string;
                       PrefixName:string;
                       FormatZip:integer;
                       CompressZip:integer;
                       CryptZip:integer;
                       CryptWord:string;
                       CryptFileName:integer;
                       TipTask:integer;
                       TimeTask:TDatetime;
                       DayMonthTask:integer;
                       OnTask:integer;
                       SelDay:string;
                       SelMonth:string;
                       modeEdit:integer);
    procedure popDelClick(Sender: TObject);
    procedure popOnClick(Sender: TObject);
    procedure popOffClick(Sender: TObject);
    procedure popEditClick(Sender: TObject);
    procedure dbSettingCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  SetTask;

{$R *.dfm}

procedure TfrmMain.ADDSetting();
begin
  // добавляем данные
  dbStack.Append;
  dbStack.FieldByName('ID').AsString := DateTimeToStr(Now());
  dbStack.FieldByName('NameTask').AsString := 'Название задачи';
  dbStack.FieldByName('StartTime').AsDateTime := Now();
  dbStack.FieldByName('OnExec').AsString := 'Ожидает';

  dbStack.Post;

end;

procedure TfrmMain.popEditClick(Sender: TObject);
begin
  // настраиваем редактирование
  frmSetTask.modeEdit := 'EDIT';
  frmSetTask.initEDIT(dbSettingNameTask.AsString,
                      dbSettingFromZip.AsString,
                      dbSettingToZip.AsString,
                      dbSettingPrefixName.AsString,

                      dbSettingFormatZip.AsInteger,
                      dbSettingCompressZip.AsInteger,
                      dbSettingCryptZip.AsInteger,
                      dbSettingCryptWord.AsString,
                      dbSettingCryptFileName.AsInteger,

                      dbSettingTipTask.AsInteger,
                      dbSettingTimeTask.AsDateTime,
                      dbSettingDayMonthTask.AsInteger,
                      dbSettingOnTask.AsInteger,
                      dbSettingSelDay.AsString,
                      dbSettingSelMonth.AsString    )  ;

  frmSetTask.ShowModal ;

end;

procedure TfrmMain.AppEventsMinimize(Sender: TObject);
begin
  TrayIcon.visible:=true;
  //Убираем с панели задач
  ShowWindow(Handle,SW_HIDE);  // Скрываем программу
  ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
  GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  // добавляем в локальную базу информацию о задаче
  AddSetting();
end;

procedure TfrmMain.dbSettingCalcFields(DataSet: TDataSet);
begin
  // готовим вычисляемые поля
  dbSettingOnTaskv.AsString := ifthen(dbSettingOnTask.AsInteger=1, '+', ' ')  ;

end;

procedure TfrmMain.popAddClick(Sender: TObject);
begin
  // добавляем задачу
  frmSetTask.modeEdit := 'ADD';
  frmSetTask.initADD();
  frmSetTask.ShowModal ;

end;

procedure TfrmMain.popDelClick(Sender: TObject);
begin

  if MessageDlg('Удалить задачу?' ,mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      dbSetting.Delete;
    end;

end;

procedure TfrmMain.popOffClick(Sender: TObject);
begin
  dbSetting.Edit;
  dbSetting.FieldByName('OnTask').AsInteger := 0;
  dbSetting.Post;

end;

procedure TfrmMain.popOnClick(Sender: TObject);
begin
  dbSetting.Edit;
  dbSetting.FieldByName('OnTask').AsInteger := 1;
  dbSetting.Post;

end;

procedure TfrmMain.popRestoreClick(Sender: TObject);
begin
  // восстанавливаем окно из трея
  TrayIcon.ShowBalloonHint;
  ShowWindow(Handle,SW_RESTORE);
  SetForegroundWindow(Handle);
  TrayIcon.Visible:=False;
end;

procedure TfrmMain.popTaskPopup(Sender: TObject);
begin
  //настраиваем popTask
  if (dbSetting.Eof) then
  begin
    popAdd.Enabled := True;
    popEdit.Enabled := false;
    popDel.Enabled := false;
    popOn.Enabled := False;
    popOff.Enabled := false;
   end
  else
  begin
    popAdd.Enabled := True;
    popEdit.Enabled := true;
    popDel.Enabled := true;
    popOn.Enabled := true;
    popOff.Enabled := true;
  end;


  if dbSettingOnTask.AsInteger = 1 then
  begin
    popOn.Visible := False;
    popOff.Visible := true;
  end
  else
  begin
    popOn.Visible := true;
    popOff.Visible := false;
  end;

end;

procedure TfrmMain.SaveSetting(NameTask, FromZip, ToZip, PrefixName: string;
  FormatZip, CompressZip, CryptZip: integer; CryptWord: string; CryptFileName,
  TipTask: integer; TimeTask: TDatetime; DayMonthTask, OnTask: integer; SelDay,
  SelMonth: string; modeEdit:integer);
var
  tmpDT:Tdatetime;
begin
  // Сохраняем даныные
  if modeEdit=0 then
    dbSetting.Append
  else
    dbSetting.Edit;
  dbSetting.FieldByName('ID').AsString := DateTimeToStr(Now());
  dbSetting.FieldByName('NameTask').AsString := NameTask;
  dbSetting.FieldByName('FromZip').AsString := FromZip;
  dbSetting.FieldByName('ToZip').AsString := ToZip;
  dbSetting.FieldByName('PrefixName').AsString := PrefixName;

  dbSetting.FieldByName('FormatZip').AsInteger := FormatZip;
  dbSetting.FieldByName('CompressZip').AsInteger := CompressZip;
  dbSetting.FieldByName('CryptZip').AsInteger := CryptZip;
  dbSetting.FieldByName('CryptWord').AsString := CryptWord;
  dbSetting.FieldByName('CryptFileName').AsInteger := CryptFileName;

  dbSetting.FieldByName('TipTask').AsInteger := TipTask;
  dbSetting.FieldByName('TimeTask').AsDateTime := TimeTask;
  dbSetting.FieldByName('DayMonthTask').AsInteger := DayMonthTask;
  dbSetting.FieldByName('OnTask').AsInteger := OnTask;
  dbSetting.FieldByName('SelDay').AsString := SelDay;
  dbSetting.FieldByName('SelMonth').AsString := SelMonth;

  tmpDT := FindNextStart(TipTask, TimeTask, SelDay, SelMonth, DayMonthTask)  ;

  dbSetting.FieldByName('NextStart').AsDateTime := tmpDT; //!!!!!!!!!!!!!
  dbSetting.FieldByName('NextStartStr').AsString := DateTimeToStr(tmpDT);
  if modeEdit=0 then
    dbSetting.FieldByName('LastStart').AsString := 'Никогда' ;
  dbSetting.Post;
end;



function TfrmMain.FindNextStart(TipTask: integer; TimeTask: TDateTime; SelDay,
  SelMonth: string; DayMonthTask: integer): TDateTime;
var
  tmpYear, tmpMonth, tmpDay, tmpHour, tmpMinute, tmpSecond, tmpMSec: Word;
  tmpDateTime, DateTimeStart, currDateTime, findDateTime:TDateTime;
  currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec: Word;
  currDayWeek: word;
  findDay: Word;
  I: Word;
  noDateTime: Boolean;
begin

  noDateTime := false;
  //определяем время следующего старта задачи
  DecodeTime(TimeTask, tmpHour, tmpMinute, tmpSecond, tmpMSec);

  //фиксируем текущие дату и время
  DecodeDateTime(Now(), currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);
  currDateTime := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, 0, 0);

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

    // принимаем точку поиска за текущую дату и время
    //findDateTime := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);

    // определяем дату время старта как конец слудующей недели
    if True then

    DateTimeStart := IncDay(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 14-CurrDayWeek);

    //перебираем дни недели для определения дня старта задачи
    for I := 1 to 7 do
    begin

      // проверить есть ли на данный день недели старт задачи
      if midStr(SelDay, I, 1) = '1' then
      begin
        //формируем на день недели дату и время старта
        tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I + 1);
 
        // если старт задачи  прошел то определяем его на следующую неделю
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I + 1);

        // если найденное tmpDateTime позже currDateTime и DateTimeStart раньше определенного как самое крайнее сохраняем его
        if (tmpDateTime < DateTimeStart) and (tmpDateTime > currDateTime) then
          DateTimeStart := tmpDateTime;
         
          
      end;

      

    end;





     





   end;



  Result := DateTimeStart;

end;

end.
