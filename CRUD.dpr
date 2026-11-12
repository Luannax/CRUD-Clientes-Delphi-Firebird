program CRUD;

uses
  Vcl.Forms,
  tCRUD in 'tCRUD.pas' {FrmCadastroCliente},
  uDM in 'uDM.pas' {DM: TDataModule},
  uListaClientes in 'uListaClientes.pas' {FrmListaClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmCadastroCliente, FrmCadastroCliente);
  Application.Run;
end.
