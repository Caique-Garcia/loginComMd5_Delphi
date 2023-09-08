unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    pnlLoginArea: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    EditLogin: TEdit;
    EditSenha: TEdit;
    Shape3: TShape;
    SpeedButton1: TSpeedButton;
    Shape4: TShape;
    btnCadastrar: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    Function MD5String(Const Value : String): String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Cadastro,
  UnitDm,
  IdHashMessageDigest;

{$R *.dfm}

procedure TForm1.btnCadastrarClick(Sender: TObject);
var
  TelaCadastro: TFormCadastro;
begin
  TelaCadastro:= TFormCadastro.Create(nil);
  TelaCadastro.Show;
end;

function TForm1.MD5String(const Value: String): String;
var
   xMD5: TIdHashMessageDigest5;
begin
  //Encripitando os a string
   xMD5 := TIdHashMessageDigest5.Create;
    try
      Result := xMD5.HashStringAsHex(Value);
    finally
      xMD5.Free;
    end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  Consulta: String;
begin
  Consulta:= 'Select login, senha from user where login = :login';
  With Dm.Qry do
  begin
    Close;
    Sql.Clear;
    Sql.Text := Consulta;
    ParamByName('login').AsString := EditLogin.Text;
    Active := True;

    if RecordCount > 0 then
    begin
      if FieldByName('senha').AsString = MD5String(EditSenha.Text) then
      begin
        ShowMessage('Usuario Logado!');
      end
      else
      begin
        ShowMessage('Senha Incorreta!');
      end;
    end
    else
    begin
      ShowMessage('Usuario não cadastrado!');
    end;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
