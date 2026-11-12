unit tCRUD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes, FireDAC.Comp.Client, uDM;

type
  TFrmCadastroCliente = class(TForm)
    Titulo: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    footer: TPanel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    Panel5: TPanel;
    Panel6: TPanel;
    EditNome: TEdit;
    LabelNome: TLabel;
    EditEmail: TEdit;
    EditTelefone: TEdit;
    EditCpfCnpj: TEdit;
    LabelEmail: TLabel;
    LabelCpfCnpj: TLabel;
    LabelTelefone: TLabel;
    EditCep: TEdit;
    EditBairro: TEdit;
    EditEndereco: TEdit;
    EditNumero: TEdit;
    EditCidade: TEdit;
    LabelCep: TLabel;
    LabelEndereco: TLabel;
    LabelBairro: TLabel;
    LabelCidade: TLabel;
    LabelNumero: TLabel;
    CheckBoxClienteAtivo: TCheckBox;
    CbxUF: TComboBox;
    LabelUf: TLabel;
    BtnVerClientes: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnVerClientesClick(Sender: TObject);
  private
    FClienteId: Integer; // 0 = novo, maior que 0 = editando
    procedure LimparCampos;
    procedure CarregarCliente(AId: Integer);
    function Validar: Boolean;
  public
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

{$R *.dfm}

uses
  uListaClientes;

procedure TFrmCadastroCliente.FormShow(Sender: TObject);
begin
  LimparCampos;
end;

// Volta a tela para o modo "Novo Cliente"
procedure TFrmCadastroCliente.LimparCampos;
begin
  FClienteId := 0;
  Titulo.Caption := 'Novo Cliente';
  EditNome.Clear;
  EditCpfCnpj.Clear;
  EditEmail.Clear;
  EditTelefone.Clear;
  EditCep.Clear;
  EditEndereco.Clear;
  EditNumero.Clear;
  EditBairro.Clear;
  EditCidade.Clear;
  CbxUF.ItemIndex := -1;
  CheckBoxClienteAtivo.Checked := True;
  EditNome.SetFocus;
end;

// Busca o cliente no banco e coloca a tela em modo "Editar"
procedure TFrmCadastroCliente.CarregarCliente(AId: Integer);
begin
  DM.QryCadastro.Close;
  DM.QryCadastro.SQL.Text := 'SELECT * FROM CLIENTES WHERE ID = :ID';
  DM.QryCadastro.ParamByName('ID').AsInteger := AId;
  DM.QryCadastro.Open;

  if DM.QryCadastro.IsEmpty then
    Exit;

  FClienteId := AId;
  Titulo.Caption := 'Editar Cliente';

  EditNome.Text     := DM.QryCadastro.FieldByName('NOME').AsString;
  EditCpfCnpj.Text  := DM.QryCadastro.FieldByName('CPF_CNPJ').AsString;
  EditEmail.Text    := DM.QryCadastro.FieldByName('EMAIL').AsString;
  EditTelefone.Text := DM.QryCadastro.FieldByName('TELEFONE').AsString;
  EditCep.Text      := DM.QryCadastro.FieldByName('CEP').AsString;
  EditEndereco.Text := DM.QryCadastro.FieldByName('ENDERECO').AsString;
  EditNumero.Text   := DM.QryCadastro.FieldByName('NUMERO').AsString;
  EditBairro.Text   := DM.QryCadastro.FieldByName('BAIRRO').AsString;
  EditCidade.Text   := DM.QryCadastro.FieldByName('CIDADE').AsString;
  CbxUF.ItemIndex   := CbxUF.Items.IndexOf(Trim(DM.QryCadastro.FieldByName('UF').AsString));
  CheckBoxClienteAtivo.Checked := DM.QryCadastro.FieldByName('ATIVO').AsString = 'S';

  DM.QryCadastro.Close;
  EditNome.SetFocus;
end;

function TFrmCadastroCliente.Validar: Boolean;
begin
  Result := False;

  if Trim(EditNome.Text) = '' then
  begin
    MessageDlg('Informe o nome do cliente.', mtWarning, [mbOK], 0);
    EditNome.SetFocus;
    Exit;
  end;

  if (Trim(EditEmail.Text) <> '') and (Pos('@', EditEmail.Text) = 0) then
  begin
    MessageDlg('E-mail inválido.', mtWarning, [mbOK], 0);
    EditEmail.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmCadastroCliente.BtnSalvarClick(Sender: TObject);
var
  Ativo: string;
begin
  if not Validar then
    Exit;

  if CheckBoxClienteAtivo.Checked then
    Ativo := 'S'
  else
    Ativo := 'N';

  try
    if FClienteId = 0 then
    begin
      // C do CRUD: cliente novo
      DM.FDConn.ExecSQL(
        'INSERT INTO CLIENTES (NOME, CPF_CNPJ, EMAIL, TELEFONE, CEP, ENDERECO, ' +
        'NUMERO, BAIRRO, CIDADE, UF, ATIVO) VALUES (:NOME, :CPF_CNPJ, :EMAIL, ' +
        ':TELEFONE, :CEP, :ENDERECO, :NUMERO, :BAIRRO, :CIDADE, :UF, :ATIVO)',
        [Trim(EditNome.Text), EditCpfCnpj.Text, EditEmail.Text, EditTelefone.Text,
         EditCep.Text, EditEndereco.Text, EditNumero.Text, EditBairro.Text,
         EditCidade.Text, CbxUF.Text, Ativo]);
      ShowMessage('Cliente cadastrado com sucesso!');
    end
    else
    begin
      // U do CRUD: atualiza o cliente carregado
      DM.FDConn.ExecSQL(
        'UPDATE CLIENTES SET NOME = :NOME, CPF_CNPJ = :CPF_CNPJ, EMAIL = :EMAIL, ' +
        'TELEFONE = :TELEFONE, CEP = :CEP, ENDERECO = :ENDERECO, NUMERO = :NUMERO, ' +
        'BAIRRO = :BAIRRO, CIDADE = :CIDADE, UF = :UF, ATIVO = :ATIVO ' +
        'WHERE ID = :ID',
        [Trim(EditNome.Text), EditCpfCnpj.Text, EditEmail.Text, EditTelefone.Text,
         EditCep.Text, EditEndereco.Text, EditNumero.Text, EditBairro.Text,
         EditCidade.Text, CbxUF.Text, Ativo, FClienteId]);
      ShowMessage('Cliente atualizado com sucesso!');
    end;

    LimparCampos;
  except
    on E: Exception do
      MessageDlg('Erro ao salvar: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmCadastroCliente.BtnCancelarClick(Sender: TObject);
begin
  LimparCampos;
end;

// R do CRUD: abre a lista; se escolher Alterar, carrega o cliente aqui
procedure TFrmCadastroCliente.BtnVerClientesClick(Sender: TObject);
var
  Lista: TFrmListaClientes;
begin
  Lista := TFrmListaClientes.Create(Self);
  try
    if Lista.ShowModal = mrOk then
      CarregarCliente(Lista.ClienteSelecionado);
  finally
    Lista.Free;
  end;
end;

end.
