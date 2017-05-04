unit uSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TfrmSobre = class(TfrmCadastroPadrao)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

{$R *.dfm}

procedure TfrmSobre.BitBtn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmSobre.BitBtn2Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmSobre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  
  if key = VK_ESCAPE THEN
  close;
end;

end.
