object FrmListaClientes: TFrmListaClientes
  Left = 0
  Top = 0
  Caption = 'Lista de Clientes'
  ClientHeight = 480
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 798
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 792
    object BtnAlterar: TButton
      Left = 1
      Top = 1
      Width = 75
      Height = 63
      Align = alLeft
      Caption = 'Alterar'
      TabOrder = 0
      OnClick = BtnAlterarClick
      ExplicitLeft = 576
      ExplicitTop = 32
      ExplicitHeight = 25
    end
    object BtnExcluir: TButton
      Left = 100
      Top = 1
      Width = 75
      Height = 63
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = BtnExcluirClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 798
    Height = 415
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 70
    ExplicitWidth = 792
    object GridClientes: TDBGrid
      Left = 16
      Top = 24
      Width = 761
      Height = 369
      DataSource = DM.DsClientes
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = GridClientesDblClick
    end
  end
end
