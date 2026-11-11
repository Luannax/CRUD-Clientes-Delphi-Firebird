unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConn: TFDConnection;
    FDDriverFB: TFDPhysFBDriverLink;
    FDWaitCursor: TFDGUIxWaitCursor;
    QryClientes: TFDQuery;
    DsClientes: TDataSource;
    QryCadastro: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  public
    procedure ListarClientes(const ACampo, ATexto: string);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

const
  CAMINHO_BANCO = 'E:\Delphi\CRUD - Cadastro de Pessoas\db\CLIENTES.FDB';

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FDConn.Connected := False;
  FDConn.Params.Clear;
  FDConn.Params.Add('DriverID=FB');
  FDConn.Params.Add('Server=localhost');
  FDConn.Params.Add('Database=' + CAMINHO_BANCO);
  FDConn.Params.Add('User_Name=SYSDBA');
  FDConn.Params.Add('Password=masterkey'); // a sua senha
  FDConn.Params.Add('CharacterSet=UTF8');
  FDConn.LoginPrompt := False;
  FDConn.Connected := True;
end;

// Abre a lista de clientes, filtrando se houver texto de pesquisa
procedure TDM.ListarClientes(const ACampo, ATexto: string);
begin
  QryClientes.Close;
  QryClientes.SQL.Clear;
  QryClientes.SQL.Add('SELECT ID, NOME, CPF_CNPJ, TELEFONE, CIDADE, UF');
  QryClientes.SQL.Add('FROM CLIENTES');

  if Trim(ATexto) <> '' then
  begin
    QryClientes.SQL.Add('WHERE UPPER(' + ACampo + ') LIKE :TEXTO');
    QryClientes.ParamByName('TEXTO').AsString := '%' + UpperCase(Trim(ATexto)) + '%';
  end;

  QryClientes.SQL.Add('ORDER BY NOME');
  QryClientes.Open;
end;

end.
