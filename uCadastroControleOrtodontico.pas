unit uCadastroControleOrtodontico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastroPadrao, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, jpeg;

type
  TfrmCadastroControleOrtodontico = class(TfrmCadastroPadrao)
    dtEntrada: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    edtPaciente: TEdit;
    Label4: TLabel;
    edtAparelho: TEdit;
    Label5: TLabel;
    edtModelo: TEdit;
    edtCliente: TEdit;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    rgStatus: TRadioGroup;
    dtSaida: TDateTimePicker;
    lblDtSaida: TLabel;
    qryConsultaUltimaCodigoMax: TLargeintField;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgStatusClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroControleOrtodontico: TfrmCadastroControleOrtodontico;
  iTipoOperacao : integer; // 1- Inclusão ~ 2- Edição
implementation

uses StrUtils, uPrincipalOrtoControl, uPesquisaCliente;

{$R *.dfm}

procedure TfrmCadastroControleOrtodontico.BitBtn2Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmCadastroControleOrtodontico.FormShow(Sender: TObject);
begin
  inherited;
  if iTipoOperacao = 1 then  //Inclusão
  begin
    qryConsultaUltimaCodigo.Close;
    qryConsultaUltimaCodigo.SQL.Clear;
    qryConsultaUltimaCodigo.SQL.Add('select max(c.i_cod_controle) +1 "Max" ');
    qryConsultaUltimaCodigo.SQL.Add('from controle c                        ');
    qryConsultaUltimaCodigo.Open;
    edtCodigo.Text := IntToStr( qryConsultaUltimaCodigo.FieldByName('Max').AsInteger );
    dtEntrada.Date := now;
    lblDtSaida.Visible := false;
    dtSaida.Visible := false;
  end;

  if iTipoOperacao = 2 then   //Edição
  begin
    edtCodigo.Text := uPrincipalOrtoControl.sCodigo;
    dtEntrada.Date := StrToDate(uPrincipalOrtoControl.sDtEntrada);
    edtPaciente.Text := uPrincipalOrtoControl.sPaciente;
    edtAparelho.Text := uPrincipalOrtoControl.sAparelho;
    edtModelo.Text := uPrincipalOrtoControl.sQtdModelo;
    edtCliente.Text := uPrincipalOrtoControl.sCodigoCli + ' - ' + uPrincipalOrtoControl.sCliente;

    if uPrincipalOrtoControl.sStatus = 'Em Aberto' then
    rgStatus.ItemIndex := 0
    else
    rgStatus.ItemIndex := 1;

    if uPrincipalOrtoControl.sDtSaida <> '' then
    dtSaida.Date := StrToDate(uPrincipalOrtoControl.sDtSaida);

    if uPrincipalOrtoControl.sDtSaida = '' then
    begin
      lblDtSaida.Visible := false;
      dtSaida.Visible := false;
    end;

  end;

  edtCodigo.Enabled := false;
  dtEntrada.SetFocus;

end;

procedure TfrmCadastroControleOrtodontico.rgStatusClick(Sender: TObject);
begin
  inherited;
  if rgStatus.ItemIndex = 0 then
  begin
    lblDtSaida.Visible := false;
    dtSaida.Visible := false;
  end
  else
  begin
    lblDtSaida.Visible := true;
    dtSaida.Visible := true;
    dtSaida.Date := now;
  end;
end;

procedure TfrmCadastroControleOrtodontico.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if iTipoOperacao = 1 then  //Inclusão
  begin
    with qryPadrao do
    begin
      close;
      SQL.Clear;
      SQL.Add('INSERT INTO CONTROLE (I_COD_CONTROLE, DT_ENTRADA_CONTROLE, S_NOME_PACIENTE_CONTROLE, S_DESCRICAO_APARELHO_CONTROLE,                ');
      SQL.Add('                      S_QTD_MODELO_CONTROLE, I_COD_CLIENTE, S_STATUS_CONTROLE, DT_SAIDA_CONTROLE)                                  ');
      SQL.Add('              VALUES (:P_I_COD_CONTROLE, :P_DT_ENTRADA_CONTROLE, :P_S_NOME_PACIENTE_CONTROLE, :P_S_DESCRICAO_APARELHO_CONTROLE,    ');
      SQL.Add('                      :P_S_QTD_MODELO_CONTROLE, :P_I_COD_CLIENTE, :P_S_STATUS_CONTROLE, :P_DT_SAIDA_CONTROLE)                      ');
      ParamByName('P_I_COD_CONTROLE').AsInteger := 0;
      ParamByName('P_DT_ENTRADA_CONTROLE').AsDate := dtEntrada.Date;
      ParamByName('P_S_NOME_PACIENTE_CONTROLE').AsString := edtPaciente.Text;
      ParamByName('P_S_DESCRICAO_APARELHO_CONTROLE').AsString := edtAparelho.Text;
      ParamByName('P_S_QTD_MODELO_CONTROLE').AsString := edtModelo.Text;
      ParamByName('P_I_COD_CLIENTE').AsInteger := StrToInt( Copy(edtCliente.Text, 0, Pos('-', edtCliente.Text)- 2 ) );
      if rgStatus.ItemIndex = 0 then
      ParamByName('P_S_STATUS_CONTROLE').AsString := 'Em Aberto';
      if rgStatus.ItemIndex = 1 then
      ParamByName('P_S_STATUS_CONTROLE').AsString := 'Correio';
      if rgStatus.ItemIndex = 0 then
      ParamByName('P_DT_SAIDA_CONTROLE').DataType := ftDate
      else
      ParamByName('P_DT_SAIDA_CONTROLE').AsDate := dtSaida.Date;

      ExecSQL;
    end;
  end;

  if iTipoOperacao = 2 then  //Edição
  begin
    with qryPadrao do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE CONTROLE SET DT_ENTRADA_CONTROLE = :P_DT_ENTRADA_CONTROLE'                                   + ' ,' );
      SQL.Add('                    S_NOME_PACIENTE_CONTROLE = ' + QuotedStr(edtPaciente.Text)                      + ' ,' );
      SQL.Add('                    S_DESCRICAO_APARELHO_CONTROLE = ' + QuotedStr(edtAparelho.Text)                 + ' ,' );
      SQL.Add('                    S_QTD_MODELO_CONTROLE = ' + QuotedStr(edtModelo.Text)                           + ' ,' );
      SQL.Add('                    I_COD_CLIENTE = ' + Copy(edtCliente.Text, 0, Pos('-', edtCliente.Text)- 2 )     + ' ,' );

      if rgStatus.ItemIndex = 0 then
      SQL.Add('                    S_STATUS_CONTROLE = ' + QuotedStr('Em Aberto')                                  + ' ,' );
      if rgStatus.ItemIndex = 1 then
      SQL.Add('                    S_STATUS_CONTROLE = ' + QuotedStr('Correio')                                    + ' ,' );

      SQL.Add('                    DT_SAIDA_CONTROLE = :P_DT_SAIDA_CONTROLE'                                              );
      SQL.Add('WHERE I_COD_CONTROLE = ' + edtCodigo.Text                                                                  );

      ParamByName('P_DT_ENTRADA_CONTROLE').AsDate := dtEntrada.Date;
      if rgStatus.ItemIndex = 0 then
      ParamByName('P_DT_SAIDA_CONTROLE').DataType := ftDate
      else
      ParamByName('P_DT_SAIDA_CONTROLE').AsDate := dtSaida.Date;


      ExecSQL;
    end;
  end;

    frmPrincipalOrtoControl.qrySqlControle.Close;
    frmPrincipalOrtoControl.qrySqlControle.Open;
    frmCadastroControleOrtodontico.Close;
end;

procedure TfrmCadastroControleOrtodontico.SpeedButton1Click(
  Sender: TObject);
begin
  inherited;
  frmPesquisaCliente := TfrmPesquisaCliente.Create(Application);
  frmPesquisaCliente.ShowModal;
  frmPesquisaCliente.Free;
end;

procedure TfrmCadastroControleOrtodontico.edtClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    frmPesquisaCliente := TfrmPesquisaCliente.Create(Application);
    frmPesquisaCliente.edtCliente.Text := edtCliente.Text;
    frmPesquisaCliente.BuscarCliente;
    frmPesquisaCliente.ShowModal;
    frmPesquisaCliente.Free;
  end;
end;

procedure TfrmCadastroControleOrtodontico.Button1Click(Sender: TObject);
begin
  inherited;
//
  ShowMessage(Copy(edtCliente.Text, 0, Pos('-', edtCliente.Text)- 1 ) );
end;

procedure TfrmCadastroControleOrtodontico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE THEN
  close;
end;

end.
