unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Vcl.AppEvnts, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.DBCtrls;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    TrayIcon: TTrayIcon;
    popTray: TPopupMenu;
    popRestore: TMenuItem;
    AppEvents: TApplicationEvents;
    dbSetting: TClientDataSet;
    dbSettingID: TIntegerField;
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
    dbSettingDayTask: TIntegerField;
    dbSettingMonthTask: TIntegerField;
    dbSettingDayMonthTask: TIntegerField;
    dsSetting: TDataSource;
    Button1: TButton;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    popTask: TPopupMenu;
    popAdd: TMenuItem;
    popOn: TMenuItem;
    popDel: TMenuItem;
    popOff: TMenuItem;
    dbSettingOnTask: TIntegerField;
    dbSettingCryptZip: TIntegerField;
    procedure popRestoreClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure popTaskPopup(Sender: TObject);
    procedure popAddClick(Sender: TObject);

    procedure AddSetting();
    procedure popDelClick(Sender: TObject);
    procedure popOnClick(Sender: TObject);
    procedure popOffClick(Sender: TObject);
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

procedure TfrmMain.AddSetting;
begin
  // добавляем данные
  dbSetting.Append;
  dbSetting.FieldByName('NameTask').AsString := 'Имя задачи';
  dbSetting.FieldByName('FromZip').AsString := 'Что архивировать';
  dbSetting.FieldByName('ToZip').AsString := 'Куда архивировать';
  dbSetting.FieldByName('PrefixName').AsString := 'Префик имени архива';
  dbSetting.FieldByName('FormatZip').AsInteger := 0;
  dbSetting.FieldByName('CompressZip').AsInteger := 2;
  dbSetting.FieldByName('CryptZip').AsInteger := 0;
  dbSetting.FieldByName('CryptWord').AsString := 'пароль';
  dbSetting.FieldByName('CryptFileName').AsInteger := 0;
  dbSetting.FieldByName('TipTask').AsInteger := 0;
  dbSetting.FieldByName('TimeTask').AsDateTime := Now();
  dbSetting.FieldByName('DayTask').AsInteger := 1;
  dbSetting.FieldByName('MonthTask').AsInteger := 1;
  dbSetting.FieldByName('DayMonthTask').AsInteger := 1;
  dbSetting.FieldByName('OnTask').AsInteger := 1;
  dbSetting.Post;



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
  addSetting();
end;

procedure TfrmMain.popAddClick(Sender: TObject);
begin
  // добавляем задачу
  frmSetTask.modeEdit := 'ADD';
  frmSetTask.initSet();
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
    popOn.Visible := true;
    popOn.Enabled := false;
    popOff.Visible := False;
    popDel.Enabled := false;
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

end.
