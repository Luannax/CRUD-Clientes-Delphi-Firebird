unit uListaClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmListaClientes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    GridClientes: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure GridClientesDblClick(Sender: TObject);
  private
  public
    ClienteSelecionado: Integer;
  end;

var
  FrmListaClientes: TFrmListaClientes;

implementation

{$R *.dfm}

uses
  System.UITypes, uDM;

// Ao abrir, lista todos os clientes
procedure TFrmListaClientes.FormShow(Sender: TObject);
begin
  DM.ListarClientes('NOME', '');
end;

// Guarda o ID escolhido e fecha a lista avisando "ok"
procedure TFrmListaClientes.BtnAlterarClick(Sender: TObject);
begin
  if DM.QryClientes.IsEmpty then
    Exit;
  ClienteSelecionado := DM.QryClientes.FieldByName('ID').AsInteger;
  ModalResult := mrOk;
end;

// Duplo clique numa linha = mesmo que Alterar
procedure TFrmListaClientes.GridClientesDblClick(Sender: TObject);
begin
  BtnAlterarClick(Sender);
end;

procedure TFrmListaClientes.BtnExcluirClick(Sender: TObject);
var
  Id: Integer;
  Nome: string;
begin
  if DM.QryClientes.IsEmpty then
    Exit;

  Id := DM.QryClientes.FieldByName('ID').AsInteger;
  Nome := DM.QryClientes.FieldByName('NOME').AsString;

  if MessageDlg('Deseja excluir o cliente "' + Nome + '"?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DM.FDConn.ExecSQL('DELETE FROM CLIENTES WHERE ID = :ID', [Id]);
    DM.ListarClientes('NOME', '');
  end;
end;

end.
