unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Vcl.AppEvnts, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.DBCtrls, System.StrUtils, Vcl.ComCtrls,
  System.DateUtils, Data.Win.ADODB, System.ImageList, Vcl.ImgList;

type


  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    TrayIcon: TTrayIcon;
    popTray: TPopupMenu;
    popRestore: TMenuItem;
    AppEvents: TApplicationEvents;
    popTask: TPopupMenu;
    popAdd: TMenuItem;
    popOn: TMenuItem;
    popDel: TMenuItem;
    popOff: TMenuItem;
    popEdit: TMenuItem;
    N1: TMenuItem;
    pgTask: TPageControl;
    tabTask: TTabSheet;
    DBGrid1: TDBGrid;
    tabStack: TTabSheet;
    memLog: TMemo;
    Label1: TLabel;
    DBGrid2: TDBGrid;
    TimerTask: TTimer;
    TimerStack: TTimer;
    ImageList: TImageList;
    popStack: TPopupMenu;
    popDelStack: TMenuItem;
    tmpMemo: TMemo;
    procedure popRestoreClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure popTaskPopup(Sender: TObject);
    procedure popAddClick(Sender: TObject);

    procedure AddSetting();

    procedure SaveSetting(ID:string;
                           NameTask:string;
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
                           DayMonthTask:word;
                           OnTask:integer;
                           SelDay:string;
                           SelMonth:string;
                           modeEdit:integer;
                           kolCopy:integer;
                           LastStart:string);


    procedure popDelClick(Sender: TObject);
    procedure popOnClick(Sender: TObject);
    procedure popOffClick(Sender: TObject);
    procedure popEditClick(Sender: TObject);
    procedure TimerTaskTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerStackTimer(Sender: TObject);
    procedure popStackPopup(Sender: TObject);
    procedure pgTaskChange(Sender: TObject);

    procedure viewLog(PrefixName:string);


    procedure startAgent();
    procedure popDelStackClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);


  private
    FexecIDTask: string;
    procedure SetexecIDTask(const Value: string);
    { Private declarations }

  public
    { Public declarations }
    property execIDTask: string read FexecIDTask write SetexecIDTask;

  end;

var
  frmMain: TfrmMain;

implementation

uses
  SetTask, sevenzip, Func, unitDM, SetSrv, TLHelp32;

{$R *.dfm}

procedure TfrmMain.SetexecIDTask(const Value: string);
begin
  FexecIDTask := Value;
end;


//-------------------------------------------------

procedure TfrmMain.startAgent;
var
  startStr:string;
begin
  // запускаем службы
  startStr := 'schtasks /run /tn ArcFoldAgentStartUp '
              ;

  WinExec('schtasks /run /tn ArcFoldServiceCheck', SW_SHOW);


end;


function CloseByExeName(ExeFilename: String): Integer;
var
  continueloop: Boolean;
  fsnapshothandle: THandle;
  fprocessentry32: TProcessEntry32;
const
  //константа для команды завершения процесса
  process_terminate=$0001;
begin
  Result := 0;
  //переводим имя файла в верхний регистр для сравнения
  ExeFilename := uppercase(ExeFilename);
  //получаем снимок работабщих в системе процессов
  fsnapshothandle := createtoolhelp32snapshot(th32cs_snapprocess,0);
  fprocessentry32.dwsize := sizeof(fprocessentry32);
  continueloop := process32first(fsnapshothandle,fprocessentry32);
  //перебираем процессы
  while integer(continueloop)<>0 do
  begin
    //если имя файла совпадает с искомым, то пробуем его завершить
    if ( ( uppercase( extractfilename( fprocessentry32.szexefile ) ) = ExeFilename ) OR
         ( uppercase( fprocessentry32.szexefile ) = ExeFilename) ) then
      Result := integer( terminateprocess( openprocess( process_terminate, bool(0), fprocessentry32.th32processid ), 0) );
    //берем следующий процесс
    continueloop := process32next(fsnapshothandle,fprocessentry32);
  end;
  closehandle(fsnapshothandle);
end;

//-----------------------------------------------

procedure TfrmMain.ADDSetting();
begin
  // добавляем данные

end;

procedure TfrmMain.popEditClick(Sender: TObject);
begin
  // настраиваем редактирование
  frmSetTask.modeEdit := 'EDIT';
  frmSetTask.initEDIT(DM.dbSettingID.AsString,
                      DM.dbSettingNameTask.AsString,
                      DM.dbSettingFromZip.AsString,
                      DM.dbSettingToZip.AsString,
                      DM.dbSettingPrefixName.AsString,

                      DM.dbSettingFormatZip.AsInteger,
                      DM.dbSettingCompressZip.AsInteger,
                      DM.dbSettingCryptZip.AsInteger,
                      DM.dbSettingCryptWord.AsString,
                      DM.dbSettingCryptFileName.AsInteger,

                      DM.dbSettingTipTask.AsInteger,
                      DM.dbSettingTimeTask.AsDateTime,
                      DM.dbSettingDayMonthTask.AsInteger,
                      DM.dbSettingOnTask.AsInteger,
                      DM.dbSettingSelDay.AsString,
                      DM.dbSettingSelMonth.AsString,
                      DM.dbSettingKolCopy.AsInteger,
                      DM.dbSettingLastStart.AsString    )  ;

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

end;

// проверка стека
procedure TfrmMain.pgTaskChange(Sender: TObject);
begin
  memLog.Clear;
  if pgTask.ActivePageIndex=0 then
  begin
    DM.dbSetting.AfterScroll(DM.dbSetting);
  end;


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
      DM.dbSetting.Delete;
    end;

end;

procedure TfrmMain.popDelStackClick(Sender: TObject);
begin
  // удаляем задачу или прерываем задачу
  //выключаем задачу
   if DM.dbStackOnExec.AsInteger = 0 then
   begin
     CloseByExeName('ArcFoldService.exe');
     WinExec('schtasks /run /tn ArcFoldServiceCheck', SW_SHOW);
   end;


   DM.delExecStack.Parameters.ParamByName('ID').Value := DM.dbStackID.AsString;
   DM.delExecStack.Execute;
   DM.dbStack.Requery();


end;

procedure TfrmMain.popOffClick(Sender: TObject);
begin
    //выключаем задачу
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.dbSettingID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DM.setOnTask.Execute;
    DM.dbSettingRefresh();
    
    //DM.dbSetting.Requery();

end;

procedure TfrmMain.popOnClick(Sender: TObject);
begin
    //выключаем задачу
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.dbSettingID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 1;
    DM.setOnTask.Execute;
    DM.dbSettingRefresh();
    
    //DM.dbSetting.Requery();

end;

procedure TfrmMain.popRestoreClick(Sender: TObject);
begin
  // восстанавливаем окно из трея
  TrayIcon.ShowBalloonHint;
  ShowWindow(Handle,SW_RESTORE);
  SetForegroundWindow(Handle);
  TrayIcon.Visible:=False;
end;

procedure TfrmMain.popStackPopup(Sender: TObject);
begin
  //настраиваем popTask
  if (DM.dbStack.Eof) then
  begin
    popDelStack.Enabled := false;
   end
  else
  begin
    if DM.dbStackOnExec.AsInteger = 0 then
    begin
      popDelStack.Enabled := true;
      popDelStack.Caption := 'Удалить из очереди';
    end
    else
    begin
      popDelStack.Enabled := true;
      popDelStack.Caption := 'Прервать выполнение';
    end;
  end;

end;

procedure TfrmMain.popTaskPopup(Sender: TObject);
begin
  //настраиваем popTask
  if (DM.dbSetting.Eof) then
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


  if DM.dbSettingOnTask.AsInteger = 1 then
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


/// сохраняем настройки задачи
procedure TfrmMain.SaveSetting(ID, NameTask, FromZip, ToZip, PrefixName: string;
  FormatZip, CompressZip, CryptZip: integer; CryptWord: string; CryptFileName,
  TipTask: integer; TimeTask: TDatetime; DayMonthTask: Word; OnTask: integer; SelDay,
  SelMonth: string; modeEdit:integer; KolCopy:integer; LastStart:string);
var
  tmpDT:Tdatetime;
begin
  // Сохраняем даныные
  if modeEdit=0 then
  begin
    //выключаем задачу
    DM.addTask.Parameters.ParamByName('ID').Value := ID;
    DM.addTask.Parameters.ParamByName('NameTask').Value := NameTask;
    DM.addTask.Parameters.ParamByName('FromZip').Value := FromZip;
    DM.addTask.Parameters.ParamByName('ToZip').Value := ToZip;
    DM.addTask.Parameters.ParamByName('PrefixName').Value := PrefixName;

    DM.addTask.Parameters.ParamByName('FormatZip').Value := FormatZip;
    DM.addTask.Parameters.ParamByName('CompressZip').Value := CompressZip;
    DM.addTask.Parameters.ParamByName('CryptZip').Value := CryptZip;
    DM.addTask.Parameters.ParamByName('CryptWord').Value := CryptWord;
    DM.addTask.Parameters.ParamByName('CryptFileName').Value := CryptFileName;

    DM.addTask.Parameters.ParamByName('TipTask').Value := TipTask;
    DM.addTask.Parameters.ParamByName('TimeTask').Value := TimeTask;
    DM.addTask.Parameters.ParamByName('DayMonthTask').Value := DayMonthTask;
    DM.addTask.Parameters.ParamByName('OnTask').Value := OnTask;
    DM.addTask.Parameters.ParamByName('SelDay').Value := SelDay;
    DM.addTask.Parameters.ParamByName('SelMonth').Value := SelMonth;
    DM.addTask.Parameters.ParamByName('LogTask').Value := '';

    tmpDT := FindNextStart(TipTask, TimeTask, SelDay, SelMonth, DayMonthTask)  ;

    DM.addTask.Parameters.ParamByName('NextStart').Value := tmpDT;
    DM.addTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(tmpDT);
    DM.addTask.Parameters.ParamByName('LastStart').Value := 'Никогда' ;
    DM.addTask.Parameters.ParamByName('KolCopy').Value := KolCopy;
    DM.addTask.Execute;
    DM.dbSetting.Requery();
  end
  else
  begin
    DM.upTask.Parameters.ParamByName('ID').Value := ID;
    DM.upTask.Parameters.ParamByName('NameTask').Value := NameTask;
    DM.upTask.Parameters.ParamByName('FromZip').Value := FromZip;
    DM.upTask.Parameters.ParamByName('ToZip').Value := ToZip;
    DM.upTask.Parameters.ParamByName('PrefixName').Value := PrefixName;

    DM.upTask.Parameters.ParamByName('FormatZip').Value := FormatZip;
    DM.upTask.Parameters.ParamByName('CompressZip').Value := CompressZip;
    DM.upTask.Parameters.ParamByName('CryptZip').Value := CryptZip;
    DM.upTask.Parameters.ParamByName('CryptWord').Value := CryptWord;
    DM.upTask.Parameters.ParamByName('CryptFileName').Value := CryptFileName;

    DM.upTask.Parameters.ParamByName('TipTask').Value := TipTask;
    DM.upTask.Parameters.ParamByName('TimeTask').Value := TimeTask;
    DM.upTask.Parameters.ParamByName('DayMonthTask').Value := DayMonthTask;
    DM.upTask.Parameters.ParamByName('OnTask').Value := OnTask;
    DM.upTask.Parameters.ParamByName('SelDay').Value := SelDay;
    DM.upTask.Parameters.ParamByName('SelMonth').Value := SelMonth;
    DM.upTask.Parameters.ParamByName('LogTask').Value := '';

    tmpDT := FindNextStart(TipTask, TimeTask, SelDay, SelMonth, DayMonthTask)  ;

    DM.upTask.Parameters.ParamByName('NextStart').Value := tmpDT;
    DM.upTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(tmpDT);
    DM.upTask.Parameters.ParamByName('LastStart').Value := LastStart ;
    DM.upTask.Parameters.ParamByName('KolCopy').Value := KolCopy;
    DM.upTask.Execute;
    DM.dbSettingRefresh();
    //DM.dbSetting.Requery();
  end;
end;



// Запуск задачи - архивирование
procedure TfrmMain.TimerStackTimer(Sender: TObject);
begin
   DM.dbStack.Requery() ;
end;


procedure TfrmMain.TimerTaskTimer(Sender: TObject);
begin
  DM.dbSettingRefresh;
end;


procedure TfrmMain.viewLog(PrefixName:string) ;
var
  FileLog:string;
begin
 ///
  FileLog := DM.pathExe +'Logs\' + PrefixName + '.log';
  if DirectoryExists(DM.pathExe+'Logs') and
     FileExists(FileLog) and (pgTask.ActivePageIndex=0) then
    memLog.Lines.LoadFromFile(FileLog);

end;




//создаем и настраиваем форму
procedure TfrmMain.FormCreate(Sender: TObject);
begin

  //включаем таймеры
  timerTask.Enabled := true;
  timerStack.Enabled := true;

  // отмечаем создание формы в DM
  DM.startMain := true;
  
end;





end.


