unit Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormCadastro = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    EditName: TEdit;
    EditCPF: TEdit;
    EditRG: TEdit;
    EditEmail: TEdit;
    EditCel: TEdit;
    EditTel: TEdit;
    Shape7: TShape;
    Label2: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    EditSenha: TEdit;
    EditConfirmSenha: TEdit;
    Shape10: TShape;
    EditLogin: TEdit;
    Shape11: TShape;
    SpeedButton1: TSpeedButton;
    Shape12: TShape;
    btnFechar: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    //Função de incriptação da senha
    Function MD5String(Const Value : String): String;
    Procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.dfm}

uses UnitDm,
      IdHashMessageDigest;


procedure TFormCadastro.btnFecharClick(Sender: TObject);
begin
 Self.Destroy;
end;

procedure TFormCadastro.LimparCampos;
begin
   EditName.Text := '';
   EditCPF.Text:= '';
   EditRG.Text:= '';
   EditEmail.Text:= '';
   EditCel.Text:= '';
   EditTel.Text:= '';
   EditLogin.Text:= '';
   EditSenha.Text:= '';
end;

function TFormCadastro.MD5String(const Value: String): String;
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

procedure TFormCadastro.SpeedButton1Click(Sender: TObject);
var
  InsertText: String;
begin
   //Gravando as informações no banco
   InsertText:= 'INSERT INTO user (nome, cpf, rg, email, cel, tel, login, senha) ';
   InsertText:= InsertText +  'VALUES (:nome, :cpf, :rg, :email, :cel, :tel, :login, :senha)';

   with Dm.Qry do
   begin
     Close;
     Sql.Clear;
     Sql.Text := InsertText;
     ParamByName('nome').AsString := EditName.Text;
     ParamByName('cpf').AsString := EditCPF.Text;
     ParamByName('rg').AsString := EditRG.Text;
     ParamByName('email').AsString := EditEmail.Text;
     ParamByName('cel').AsString := EditCel.Text;
     ParamByName('tel').AsString := EditTel.Text;
     ParamByName('login').AsString := EditLogin.Text;
     ParamByName('senha').AsString := MD5String(EditSenha.Text);

     if EditSenha.Text = EditConfirmSenha.Text then
     begin
       ExecSQL;
       LimparCampos;
     end
     else
     begin
       ShowMessage('Senha diferente no campo de confirmação!');
     end;

   end;

end;

end.
