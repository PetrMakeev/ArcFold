unit SetTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.WinXPickers, Vcl.WinXCalendars, Vcl.Buttons, Vcl.NumberBox, System.StrUtils;

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
    txtDayMonth: TNumberBox;
    Label11: TLabel;
    btnSave: TButton;
    btnCancel: TButton;
    procedure cmbTipTaskChange(Sender: TObject);
    procedure sbMonthAllOnClick(Sender: TObject);
    procedure sbMonthAllOffClick(Sender: TObject);
    procedure sbWeekAllOnClick(Sender: TObject);
    procedure sbWeekAllOffClick(Sender: TObject);
    procedure initSet();
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

{$R *.dfm}

procedure TfrmSetTask.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSetTask.btnFromZipClick(Sender: TObject);
begin
  //������������ ����� �����
  if txtFromZip.Text = '' then
    SelectFolder.DefaultFolder := 'c:\'
  else
    SelectFolder.DefaultFolder := txtFromZip.Text;
  if SelectFolder.Execute then
    txtFromZip.Text := SelectFolder.FileName;
end;

procedure TfrmSetTask.btnSaveClick(Sender: TObject);
begin
  //��������� ���������� ������
  if trim(txtNameTask.Text)='' then
  begin
    showmessage('������� ��������');
    txtNameTask.SetFocus;
    exit;
  end;

  if trim(txtFromZip.Text) = '' then
  begin
    showmessage('������� ����� ��� �������������');
    btnFromZip.SetFocus;
    exit;
  end;

  if trim(txtToZip.Text) = '' then
  begin
    showmessage('������� ����� ��� ���������� ������');
    btnToZip.SetFocus;
    exit;
  end;

  if trim(txtPrefixName.Text) = '' then
  begin
    showmessage('������� ������� ����� ������');
    txtPrefixName.SetFocus;
    exit;
  end;

end;

procedure TfrmSetTask.btnToZipClick(Sender: TObject);
begin
  //������������ ����� �����
  if txtToZip.Text = '' then
    SelectFolder.DefaultFolder := 'c:\'
  else
    SelectFolder.DefaultFolder := txtToZip.Text;
  if SelectFolder.Execute then
    txtToZip.Text := SelectFolder.FileName;
end;

procedure TfrmSetTask.chbCryptZipClick(Sender: TObject);
begin
  //����������� ��������� �������� ����������
  chbCryptFileName.Visible := chbCryptZip.Checked;
  txtCryptWord1.Visible := chbCryptZip.Checked;
  txtCryptWord2.Visible := chbCryptZip.Checked;
  lblCryptWord1.Visible := chbCryptZip.Checked;
  lblCryptWord2.Visible := chbCryptZip.Checked;
end;

procedure TfrmSetTask.cmbTipTaskChange(Sender: TObject);
begin
  // ����������� ��������� �������� ���������, ����������� � ����������
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

procedure TfrmSetTask.initSet;
begin
  // ����������� ����� �� ���������� ������
  if modeEdit = 'ADD' then
  begin
    // ����� ����������
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
    txtDayMonth.ValueInt := 1;

    cmbFormatZip.ItemIndex := 0;
    cmbCompressZip.ItemIndex := 2;
    chbCryptZip.Checked := False;
    chbCryptFileName.Checked := False;
    txtCryptWord1.Text := '';
    txtCryptWord2.Text := '';
    chbCryptZipClick(Self);


  end;
end;

procedure TfrmSetTask.sbMonthAllOffClick(Sender: TObject);
begin
  //��������� ������
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
  // �������� ������
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
  //��������� ��� ������
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
  //�������� ��� ������
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
  //��������� ���������� ����� �������
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