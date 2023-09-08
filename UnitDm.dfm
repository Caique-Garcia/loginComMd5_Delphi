object DM: TDM
  OldCreateOrder = False
  Height = 164
  Width = 239
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Caique\Documents\Caique\ESTUDOS\UsandoMD5\Win3' +
        '2\Debug\db.db'
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
