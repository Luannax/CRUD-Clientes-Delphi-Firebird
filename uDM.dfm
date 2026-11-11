object DM: TDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConn: TFDConnection
    Left = 128
    Top = 96
  end
  object FDDriverFB: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files\Firebird\Firebird_5_0\fbclient.dll'
    OnDriverCreated = DataModuleCreate
    Left = 272
    Top = 96
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 432
    Top = 96
  end
  object QryClientes: TFDQuery
    Connection = FDConn
    Left = 128
    Top = 216
  end
  object DsClientes: TDataSource
    DataSet = QryClientes
    Left = 272
    Top = 216
  end
  object QryCadastro: TFDQuery
    Connection = FDConn
    Left = 408
    Top = 224
  end
end
