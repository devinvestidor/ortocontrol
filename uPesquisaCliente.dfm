inherited frmPesquisaCliente: TfrmPesquisaCliente
  Width = 669
  Caption = 'OrtoControl - Desenvolvido por Karan Alves Pereira'
  OldCreateOrder = True
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [1]
    Left = 88
    Top = 48
    Width = 41
    Height = 16
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited Panel1: TPanel
    Width = 653
    inherited lblTitulo: TLabel
      Width = 135
      Caption = 'Pesquisa Cliente'
    end
  end
  inherited edtCodigo: TEdit
    Width = 73
    CharCase = ecUpperCase
    OnExit = edtCodigoExit
    OnKeyDown = FormKeyDown
  end
  inherited Panel2: TPanel
    Width = 653
    inherited BitBtn1: TBitBtn
      Left = 455
      OnClick = BitBtn1Click
      OnKeyDown = FormKeyDown
    end
    inherited BitBtn2: TBitBtn
      Left = 555
      OnClick = BitBtn2Click
      OnKeyDown = FormKeyDown
    end
  end
  object edtCliente: TEdit [5]
    Left = 88
    Top = 64
    Width = 473
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnKeyDown = FormKeyDown
  end
  object btnFiltrar: TButton [6]
    Left = 568
    Top = 64
    Width = 75
    Height = 25
    Caption = '&Filtrar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnFiltrarClick
    OnKeyDown = FormKeyDown
  end
  object DBGrid1: TDBGrid [7]
    Left = 0
    Top = 96
    Width = 653
    Height = 285
    Align = alBottom
    DataSource = dsQryPadrao
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyDown = FormKeyDown
  end
  inherited qryPadrao: TZQuery
    SQL.Strings = (
      'select cl.i_cod_cliente "C'#243'digo",                 '
      '       cl.s_nome_cliente "Cliente",               '
      '       cl.s_endereco_cliente "Endere'#231'o",          '
      '       cl.s_num_cliente "N'#250'mero",                 '
      '       cl.s_complemento_cliente "Complemento",    '
      '       cl.s_bairro_cliente "Bairro",              '
      '       cl.s_cidade_cliente "Cidade",              '
      '       cl.s_uf_cliente "UF"        '
      'from cliente cl                                   '
      'order by cl.i_cod_cliente        ')
    Left = 344
    Top = 8
    object qryPadraoCdigo: TIntegerField
      DisplayWidth = 5
      FieldName = 'C'#243'digo'
      Required = True
    end
    object qryPadraoCliente: TStringField
      DisplayWidth = 20
      FieldName = 'Cliente'
      Size = 200
    end
    object qryPadraoEndereo: TStringField
      DisplayWidth = 27
      FieldName = 'Endere'#231'o'
      Size = 300
    end
    object qryPadraoNmero: TStringField
      DisplayWidth = 5
      FieldName = 'N'#250'mero'
      Size = 100
    end
    object qryPadraoComplemento: TStringField
      DisplayWidth = 5
      FieldName = 'Complemento'
      Size = 100
    end
    object qryPadraoBairro: TStringField
      DisplayWidth = 10
      FieldName = 'Bairro'
      Size = 100
    end
    object qryPadraoCidade: TStringField
      DisplayWidth = 15
      FieldName = 'Cidade'
      Size = 100
    end
    object qryPadraoUF: TStringField
      DisplayWidth = 2
      FieldName = 'UF'
      Size = 50
    end
  end
  inherited qryConsultaUltimaCodigo: TZQuery
    Left = 392
    Top = 8
  end
  inherited dsQryPadrao: TDataSource
    Left = 296
    Top = 8
  end
end
