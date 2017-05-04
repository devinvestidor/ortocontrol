unit uFramePadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGrids, Buttons, ExtCtrls, StdCtrls, ToolWin, ComCtrls,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, jpeg;

type
  TfrmPadraoFrame = class(TFrame)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    sbIncluir: TSpeedButton;
    Image3: TImage;
    lblTitulo: TLabel;
    sbExcluir: TSpeedButton;
    SpeedButton3: TSpeedButton;
    sbEditar: TSpeedButton;
    edtPesquisa: TEdit;
    Panel3: TPanel;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uPrincipalOrtoControl;
{$R *.dfm}

procedure TfrmPadraoFrame.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := DateToStr(Date) + ' - ' + TimeToStr(Time);
end;

procedure TfrmPadraoFrame.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

  if frmPrincipalOrtoControl.qrySqlControle.FieldByName('Status').AsString = 'Em Aberto' then
  begin
    DBGrid1.Canvas.Font.Color:= clgreen;
    DBGrid1.DefaultDrawDataCell(Rect, DBGrid1.Columns[datacol].Field, State);
  end;
end;

procedure TfrmPadraoFrame.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  sbEditar.Click;
end;

end.
