unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    FDConn: TFDConnection;
    FDDriverFB: TFDPhysFBDriverLink;
    FDWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
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
  FDConn.Params.Add('Password=masterkey'); // a senha que você definiu na instalação
  FDConn.Params.Add('CharacterSet=UTF8');
  FDConn.LoginPrompt := False;
  FDConn.Connected := True;
end;

end.
