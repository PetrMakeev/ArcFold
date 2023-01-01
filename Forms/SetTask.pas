unit SetTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.WinXPickers, Vcl.WinXCalendars, Vcl.Buttons, Vcl.NumberBox, System.StrUtils, System.Math;

type
  TfrmSetTask = class(TForm)
    txtNameTask: TEdit;
    Label1: TLabel;
    txtFromZip: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    txtToZip: TEdit;
    Label4: TLabel;
    txtPrefixName: TEdit;
    btnFromZip: TButton;
    btnToZip: TButton;
    pgSet: TPageControl;
    tabCrypt: TTabSheet;
    tabTime: TTabSheet;
    Shape1: TShape;
    Label5: TLabel;
    Label6: TLabel;
    lblCryptWord1: TLabel;
    lblCryptWord2: TLabel;
    cmbFormatZip: TComboBox;
    cmbCompressZip: TComboBox;
    chbCryptZip: TCheckBox;
    chbCryptFileName: TCheckBox;
    txtCryptWord1: TEdit;
    txtCryptWord2: TEdit;
    SelectFolder: TFileOpenDialog;
    cmbTipTask: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    txtTimeTask: TTimePicker;
    chbWeek1: TCheckBox;
    gbWeek: TGroupBox;
    Shape2: TShape;
    chbWeek2: TCheckBox;
    chbWeek3: TCheckBox;
    chbWeek4: TCheckBox;
    chbWeek5: TCheckBox;
    chbWeek6: TCheckBox;
    chbWeek7: TCheckBox;
    sbWeekAllOn: TSpeedButton;
    sbWeekAllOff: TSpeedButton;
    gbMonth: TGroupBox;
    sbMonthAllOn: TSpeedButton;
    sbMonthAllOff: TSpeedButton;
    chbMonth01: TCheckBox;
    chbMonth02: TCheckBox;
    chbMonth03: TCheckBox;
    chbMonth04: TCheckBox;
    chbMonth05: TCheckBox;
    chbMonth06: TCheckBox;
    chbMonth07: TCheckBox;
    chbMonth08: TCheckBox;
    chbMonth09: TCheckBox;
    chbMonth10: TCheckBox;
    chbMonth11: TCheckBox;
    chbMonth12: TCheckBox;
    txtDayMonthTask: TNumberBox;
    Label11: TLabel;
    btnSave: TButton;
    btnCancel: TButton;
    chbOnTask: TCheckBox;
    procedure cmbTipTaskChange(Sender: TObject);
    procedure sbMonthAllOnClick(Sender: TObject);
    procedure sbMonthAllOffClick(Sender: TObject);
    procedure sbWeekAllOnClick(Sender: TObject);
    procedure sbWeekAllOffClick(Sender: TObject);

    procedure initADD();
    procedure initEDIT(NameTask:string;
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
                       DayMonthTask:Word;
                       OnTask:integer;
                       SelDay:string;
                       SelMonth:string);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure chbCryptZipClick(Sender: TObject);
    procedure txtCryptWord1Exit(Sender: TObject);
    procedure btnFromZipClick(Sender: TObject);
    procedure btnToZipClick(Sender: TObject);
  private
    FmodeEdit: string;
    { Private declarations }
  public
    { Public declarations }
    property modeEdit: string read FmodeEdit write FmodeEdit;
  end;

var
  frmSetTask: TfrmSetTask;


implementation

uses
  Main;

{$R *.dfm}

procedure TfrmSetTask.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSetTask.btnFromZipClick(Sender: TObject);
begin
  //обрабатываем выбор папки
    SelectFolder.FileName := '';
  if txtFromZip.Text = '' then
    SelectFolder.DefaultFolder := 'c:\'
  else
    SelectFolder.DefaultFolder := txtFromZip.Text;

  if SelectFolder.Execute then
    txtFromZip.Text := SelectFolder.FileName;
end;

procedure TfrmSetTask.btnSaveClick(Sender: TObject);
var
  SelDay, SelMonth:string;
  SelCompress:integer;
begin
  //провер€ем заполнение данных
  if trim(txtNameTask.Text)='' then
  begin
    showmessage('”кажите название');
    txtNameTask.SetFocus;
    exit;
  end;

  if trim(txtFromZip.Text) = '' then
  begin
    showmessage('”кажите папку дл€ архивировани€');
    btnFromZip.SetFocus;
    exit;
  end;

  if trim(txtToZip.Text) = '' then
  begin
    showmessage('”кажите папку дл€ сохранени€ архива');
    btnToZip.SetFocus;
    exit;
  end;

  if trim(txtPrefixName.Text) = '' then
  begin
    showmessage('”кажите префикс имени архива');
    txtPrefixName.SetFocus;
    exit;
  end;

  if not DirectoryExists(txtFromZip.Text) then
  begin
    showmessage('”казанный путь не найден');
    btnFromZip.SetFocus;
    exit;
  end;



  if (cmbTipTask.ItemIndex = 1) and
      (not chbWeek1.Checked) and
      (not chbWeek2.Checked) and
      (not chbWeek3.Checked) and
      (not chbWeek4.Checked) and
      (not chbWeek5.Checked) and
      (not chbWeek6.Checked) and
      (not chbWeek7.Checked) then
  begin
    showmessage('”кажите хот€ бы один день недели');
    chbWeek1.SetFocus;
    exit;
  end;

  if (cmbTipTask.ItemIndex = 2) and
      (not chbMonth01.Checked) and
      (not chbMonth02.Checked) and
      (not chbMonth03.Checked) and
      (not chbMonth04.Checked) and
      (not chbMonth05.Checked) and
      (not chbMonth06.Checked) and
      (not chbMonth07.Checked) and
      (not chbMonth08.Checked) and
      (not chbMonth09.Checked) and
      (not chbMonth10.Checked) and
      (not chbMonth11.Checked) and
      (not chbMonth12.Checked)  then
  begin
    showmessage('”кажите хот€ бы один мес€ц');
    chbMonth01.SetFocus;
    exit;
  end;

  //компресси€
  case cmbCompressZip.ItemIndex of
    0 : SelCompress:=0;
    1 : SelCompress:=1;
    2 : SelCompress:=3;
    3 : SelCompress:=5;
    4 : SelCompress:=7;
    5 : SelCompress:=9;
    else  SelCompress:=5
  end;

  // вызываем добавление
  frmMain.SaveSetting(txtNameTask.Text,
                      txtFromZip.Text,
                      txtToZip.Text,
                      txtPrefixName.Text,
                      cmbFormatZip.ItemIndex,
                      SelCompress,
                      ifthen(chbCryptZip.Checked, 1, 0),
                      txtCryptWord1.Text,
                      ifthen(chbCryptFileName.Checked, 1, 0),
                      cmbTipTask.ItemIndex,
                      txtTimeTask.Time,
                      txtDayMonthTask.ValueInt,
                      ifthen(chbOnTask.Checked, 1, 0),
                      ifthen(chbWeek1.Checked, '1','0') +
                        ifthen(chbWeek2.Checked, '1','0') +
                        ifthen(chbWeek3.Checked, '1','0') +
                        ifthen(chbWeek4.Checked, '1','0') +
                        ifthen(chbWeek5.Checked, '1','0') +
                        ifthen(chbWeek6.Checked, '1','0') +
                        ifthen(chbWeek7.Checked, '1','0'),
                      ifthen(chbMonth01.Checked, '1', '0') +
                        ifthen(chbMonth02.Checked, '1', '0') +
                        ifthen(chbMonth03.Checked, '1', '0') +
                        ifthen(chbMonth04.Checked, '1', '0') +
                        ifthen(chbMonth05.Checked, '1', '0') +
                        ifthen(chbMonth06.Checked, '1', '0') +
                        ifthen(chbMonth07.Checked, '1', '0') +
                        ifthen(chbMonth08.Checked, '1', '0') +
                        ifthen(chbMonth09.Checked, '1', '0') +
                        ifthen(chbMonth10.Checked, '1', '0') +
                        ifthen(chbMonth11.Checked, '1', '0') +
                        ifthen(chbMonth12.Checked, '1', '0'),
                      ifthen(modeEdit='ADD', 0, 1)
                      );
  close;

end;

procedure TfrmSetTask.btnToZipClick(Sender: TObject);
begin
  //обрабатываем выбор папки
    SelectFolder.FileName := '';
  if txtToZip.Text = '' then
    SelectFolder.DefaultFolder := 'c:\'
  else
    SelectFolder.DefaultFolder := txtToZip.Text;

  if SelectFolder.Execute then
    txtToZip.Text := SelectFolder.FileName;
end;

procedure TfrmSetTask.chbCryptZipClick(Sender: TObject);
begin
  //настраиваем видимость настроек шифровани€
  //chbCryptFileName.Visible := chbCryptZip.Checked;
  txtCryptWord1.Visible := chbCryptZip.Checked;
  txtCryptWord2.Visible := chbCryptZip.Checked;
  lblCryptWord1.Visible := chbCryptZip.Checked;
  lblCryptWord2.Visible := chbCryptZip.Checked;
end;

procedure TfrmSetTask.cmbTipTaskChange(Sender: TObject);
begin
  // настраиваем видимость настроек ежедневно, еженедельно и ежемес€чно
  if cmbTipTask.ItemIndex = 1 then
  begin
    gbMonth.Visible := false;
    gbWeek.Visible := true;
  end
  else if cmbTipTask.ItemIndex = 2 then
  begin
    gbMonth.Visible := true;
    gbWeek.Visible := false;
  end
  else if cmbTipTask.ItemIndex = 0 then
  begin
    gbMonth.Visible := false;
    gbWeek.Visible := false;
  end;


end;

procedure TfrmSetTask.initADD();
begin
  // настраиваем форму по указанному режиму
  if modeEdit = 'ADD' then
  begin
    // режим добавлени€
    txtNameTask.Text := '';
    txtFromZip.Text := '';
    txtToZip.Text := '';
    txtPrefixName.Text := 'archive-';

    pgSet.TabIndex:= 0;
    cmbTipTask.ItemIndex :=0;
    txtTimeTask.Time := Now();
    gbWeek.Visible := False;
    sbWeekAllOff.Click;
    gbMonth.Visible := False;
    sbMonthAllOff.Click;
    txtDayMonthTask.ValueInt := 1;

    cmbFormatZip.ItemIndex := 0;
    cmbCompressZip.ItemIndex := 3;
    chbCryptZip.Checked := False;
    chbCryptFileName.Checked := False;
    txtCryptWord1.Text := '';
    txtCryptWord2.Text := '';
    chbCryptZipClick(Self);
    chbOnTask.Checked := true;
  end;


end;

procedure TfrmSetTask.initEDIT(NameTask, FromZip, ToZip, PrefixName: string;
  FormatZip, CompressZip, CryptZip: integer; CryptWord: string; CryptFileName,
  TipTask: integer; TimeTask: TDatetime;  DayMonthTask: Word;
  OnTask: integer; SelDay:string; SelMonth:string);
begin
  //
  // настраиваем форму по указанному режиму
  // режим редактировани€
  txtNameTask.Text := NameTask;
  txtFromZip.Text := FromZip;
  txtToZip.Text := ToZip;
  txtPrefixName.Text := PrefixName;

  pgSet.TabIndex:= 0;

  cmbTipTask.ItemIndex := TipTask;
  cmbTipTask.OnChange(Self);
  txtTimeTask.Time := TimeTask;

  chbWeek1.Checked := '1' = MidStr(SelDay,1,1);
  chbWeek2.Checked := '1' = MidStr(SelDay,2,1);
  chbWeek3.Checked := '1' = MidStr(SelDay,3,1);
  chbWeek4.Checked := '1' = MidStr(SelDay,4,1);
  chbWeek5.Checked := '1' = MidStr(SelDay,5,1);
  chbWeek6.Checked := '1' = MidStr(SelDay,6,1);
  chbWeek7.Checked := '1' = MidStr(SelDay,7,1);

  chbMonth01.Checked := '1' = MidStr(SelMonth,1,1);
  chbMonth02.Checked := '1' = MidStr(SelMonth,2,1);
  chbMonth03.Checked := '1' = MidStr(SelMonth,3,1);
  chbMonth04.Checked := '1' = MidStr(SelMonth,4,1);
  chbMonth05.Checked := '1' = MidStr(SelMonth,5,1);
  chbMonth06.Checked := '1' = MidStr(SelMonth,6,1);
  chbMonth07.Checked := '1' = MidStr(SelMonth,7,1);
  chbMonth08.Checked := '1' = MidStr(SelMonth,8,1);
  chbMonth09.Checked := '1' = MidStr(SelMonth,9,1);
  chbMonth10.Checked := '1' = MidStr(SelMonth,10,1);
  chbMonth11.Checked := '1' = MidStr(SelMonth,11,1);
  chbMonth12.Checked := '1' = MidStr(SelMonth,12,1);

  txtDayMonthTask.ValueInt := DayMonthTask;

  cmbFormatZip.ItemIndex := FormatZip;

  case cmbCompressZip.ItemIndex of
    0 : CompressZip := 0;
    1 : CompressZip := 1;
    3 : CompressZip := 2;
    5 : CompressZip := 3;
    7 : CompressZip := 4;
    9 : CompressZip := 5;
  else CompressZip := 3;
  end;


  chbCryptZip.Checked := 1 = CryptZip;
  chbCryptFileName.Checked := 1 = CryptFileName;
  txtCryptWord1.Text := CryptWord;
  txtCryptWord2.Text := CryptWord;
  chbCryptZipClick(Self);
  chbOnTask.Checked := 1 = OnTask;

end;

procedure TfrmSetTask.sbMonthAllOffClick(Sender: TObject);
begin
  //выключаем мес€цы
  chbMonth01.Checked := false;
  chbMonth02.Checked := false;
  chbMonth03.Checked := false;
  chbMonth04.Checked := false;
  chbMonth05.Checked := false;
  chbMonth06.Checked := false;
  chbMonth07.Checked := false;
  chbMonth08.Checked := false;
  chbMonth09.Checked := false;
  chbMonth10.Checked := false;
  chbMonth11.Checked := false;
  chbMonth12.Checked := false;

end;

procedure TfrmSetTask.sbMonthAllOnClick(Sender: TObject);
begin
  // включаем мес€цы
  chbMonth01.Checked := true;
  chbMonth02.Checked := true;
  chbMonth03.Checked := true;
  chbMonth04.Checked := true;
  chbMonth05.Checked := true;
  chbMonth06.Checked := true;
  chbMonth07.Checked := true;
  chbMonth08.Checked := true;
  chbMonth09.Checked := true;
  chbMonth10.Checked := true;
  chbMonth11.Checked := true;
  chbMonth12.Checked := true;


end;

procedure TfrmSetTask.sbWeekAllOffClick(Sender: TObject);
begin
  //выключаем дни недели
  chbWeek1.Checked := false;
  chbWeek2.Checked := false;
  chbWeek3.Checked := false;
  chbWeek4.Checked := false;
  chbWeek5.Checked := false;
  chbWeek6.Checked := false;
  chbWeek7.Checked := false;

end;

procedure TfrmSetTask.sbWeekAllOnClick(Sender: TObject);
begin
  //включаем дни недели
  chbWeek1.Checked := true;
  chbWeek2.Checked := true;
  chbWeek3.Checked := true;
  chbWeek4.Checked := true;
  chbWeek5.Checked := true;
  chbWeek6.Checked := true;
  chbWeek7.Checked := true;
end;

procedure TfrmSetTask.txtCryptWord1Exit(Sender: TObject);
begin
  //ѕровер€ем совпадени€ ввода паролей
  if txtCryptWord1.Text = txtCryptWord2.Text then
  begin
    txtCryptWord1.Font.Color := clGreen;
    txtCryptWord2.Font.Color := clGreen;
  end
  else
  begin
    txtCryptWord1.Font.Color := clRed;
    txtCryptWord2.Font.Color := clRed;
  end;

end;

end.
