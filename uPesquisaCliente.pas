unit uPesquisaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, ExtCtrls;

type
  TfrmPesquisaCliente = class(TfrmCadastroPadrao)
    Label2: TLabel;
    edtCliente: TEdit;
    btnFiltrar: TButton;
    DBGrid1: TDBGrid;
    qryPadraoCdigo: TIntegerField;
    qryPadraoCliente: TStringField;
    qryPadraoEndereo: TStringField;
    qryPadraoNmero: TStringField;
    qryPadraoComplemento: TStringField;
    qryPadraoBairro: TStringField;
    qryPadraoCidade: TStringField;
    qryPadraoUF: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure BuscarCliente;
  end;

var
  frmPesquisaCliente: TfrmPesquisaCliente;

implementation
uses uCadastroControleOrtodontico, uRelatorioControle;
{$R *.dfm}

procedure TfrmPesquisaCliente.FormShow(Sender: TObject);
begin
  inherited;
  BuscarCliente;
  edtCodigo.SetFocus;
end;

procedure TfrmPesquisaCliente.edtCodigoExit(Sender: TObject);
begin
  inherited;
  edtCliente.SetFocus;
end;

procedure TfrmPesquisaCliente.BitBtn2Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmPesquisaCliente.btnFiltrarClick(Sender: TObject);
begin
  inherited;
    BuscarCliente;
    DBGrid1.SetFocus;
end;

procedure TfrmPesquisaCliente.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if frmCadastroControleOrtodontico <> nil then
  frmCadastroControleOrtodontico.edtCliente.Text := qryPadraoCdigo.AsString + ' - ' + qryPadraoCliente.AsString;

  if frmRelatorioControle <> nil then
  frmRelatorioControle.edtCodigo.Text := qryPadraoCdigo.AsString + ' - ' + qryPadraoCliente.AsString;
  close;
end;

procedure TfrmPesquisaCliente.BuscarCliente;
begin
  with qryPadrao do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cl.i_cod_cliente "Código",                                       ');
    SQL.Add('       cl.s_nome_cliente "Cliente",                                     ');
    SQL.Add('       cl.s_endereco_cliente "Endereço",                                ');
    SQL.Add('       cl.s_num_cliente "Número",                                       ');
    SQL.Add('       cl.s_complemento_cliente "Complemento",                          ');
    SQL.Add('       cl.s_bairro_cliente "Bairro",                                    ');
    SQL.Add('       cl.s_cidade_cliente "Cidade",                                    ');
    SQL.Add('       cl.s_uf_cliente "UF"                                             ');
    SQL.Add('from cliente cl                                                         ');
    SQL.Add('where cl.s_nome_cliente like ' + QuotedStr('%' + edtCliente.Text + '%')  );
    if edtCodigo.Text <> '' then
    SQL.Add('  and cl.i_cod_cliente = ' + edtCodigo.Text                              );
    SQL.Add('order by cl.i_cod_cliente                                               ');
    Open;
  end;

end;

procedure TfrmPesquisaCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE THEN
  close;
end;

end.
