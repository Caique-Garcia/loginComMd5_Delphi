object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 164
  Width = 239
  object Conexao: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 53
    Top = 25
  end
  object Qry: TFDQuery
    Connection = Conexao
    Left = 96
    Top = 26
  end
end
