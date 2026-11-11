unit tCRUD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes, FireDAC.Comp.Client, uDM;

type
  TFrmCadastroCliente = class(TForm)
    Panel1: TPanel;
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
  private
    { Private declarations }
    procedure LimparCampos;
    function Validar: Boolean;
  public
    { Public declarations }
    ClienteId: Integer; // 0 = novo, maior que 0 = editar
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

{$R *.dfm}

// Ao abrir a tela, já começa limpa
procedure TFrmCadastroCliente.FormShow(Sender: TObject);
begin
  LimparCampos;
end;

// Apaga tudo e volta o cursor para o Nome
procedure TFrmCadastroCliente.LimparCampos;
begin
  EditNome.Clear;
  EditCpfCnpj.Clear;
  EditEmail.Clear;
  EditTelefone.Clear;
  EditCep.Clear;
  EditEndereco.Clear;
  EditNumero.Clear;
  EditBairro.Clear;
  EditCidade.Clear;
  CbxUF.ItemIndex := -1;              // -1 = nenhum selecionado
  CheckBoxClienteAtivo.Checked := True;
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
    DM.FDConn.ExecSQL(
      'INSERT INTO CLIENTES (NOME, CPF_CNPJ, EMAIL, TELEFONE, CEP, ENDERECO, ' +
      'NUMERO, BAIRRO, CIDADE, UF, ATIVO) VALUES (:NOME, :CPF_CNPJ, :EMAIL, ' +
      ':TELEFONE, :CEP, :ENDERECO, :NUMERO, :BAIRRO, :CIDADE, :UF, :ATIVO)',
      [Trim(EditNome.Text), EditCpfCnpj.Text, EditEmail.Text, EditTelefone.Text,
       EditCep.Text, EditEndereco.Text, EditNumero.Text, EditBairro.Text,
       EditCidade.Text, CbxUF.Text, Ativo]);

    ShowMessage('Cliente cadastrado com sucesso!');
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



end.
