unit sevenzipsfxstudiocode;

{
 This software was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, LazFileUtils, ComCtrls, sfxmaker;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    OpenSfxButton: TButton;
    OpenConfigurationButton: TButton;
    OpenArchiveButton: TButton;
    CreateButton: TButton;
    SfxField: TLabeledEdit;
    ConfigurationField: TLabeledEdit;
    ArchiveField: TLabeledEdit;
    OpenDialog: TOpenDialog;
    procedure OpenSfxButtonClick(Sender: TObject);
    procedure OpenConfigurationButtonClick(Sender: TObject);
    procedure OpenArchiveButtonClick(Sender: TObject);
    procedure CreateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SfxFieldChange(Sender: TObject);
    procedure ConfigurationFieldChange(Sender: TObject);
    procedure ArchiveFieldChange(Sender: TObject);
  private
    function check_input():boolean;
    procedure window_setup();
    procedure interface_setup();
    procedure language_setup();
    procedure setup();
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

function TMainWindow.check_input():boolean;
begin
 Result:=(Self.SfxField.Text<>'') and (Self.ConfigurationField.Text<>'') and (Self.ArchiveField.Text<>'');
end;

procedure TMainWindow.window_setup();
begin
 Application.Title:='7-ZIP SFX STUDIO';
 Self.Caption:='7-ZIP SFX STUDIO 2.4.5';
 Self.BorderStyle:=bsDialog;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.OpenSfxButton.ShowHint:=False;
 Self.OpenConfigurationButton.ShowHint:=False;
 Self.OpenArchiveButton.ShowHint:=False;
 Self.CreateButton.ShowHint:=False;
 Self.CreateButton.Enabled:=False;
 Self.SfxField.Text:='';
 Self.ConfigurationField.Text:='';
 Self.ArchiveField.Text:='';
 Self.SfxField.LabelPosition:=lpLeft;
 Self.ConfigurationField.LabelPosition:=lpLeft;
 Self.ArchiveField.LabelPosition:=lpLeft;
 Self.SfxField.Enabled:=False;
 Self.ConfigurationField.Enabled:=False;
 Self.ArchiveField.Enabled:=False;
end;

procedure TMainWindow.language_setup();
begin
 Self.OpenSfxButton.Caption:='Open';
 Self.OpenConfigurationButton.Caption:='Open';
 Self.OpenArchiveButton.Caption:='Open';
 Self.CreateButton.Caption:='Create the self-extracting archive';
 Self.SfxField.EditLabel.Caption:='A self-extracting module';
 Self.ConfigurationField.EditLabel.Caption:='A configuration file';
 Self.ArchiveField.EditLabel.Caption:='An archive';
 Self.OpenDialog.Title:='Open the existing file';
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.language_setup();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.SfxFieldChange(Sender: TObject);
begin
 Self.CreateButton.Enabled:=Self.check_input();
end;

procedure TMainWindow.ConfigurationFieldChange(Sender: TObject);
begin
 Self.CreateButton.Enabled:=Self.check_input();
end;

procedure TMainWindow.ArchiveFieldChange(Sender: TObject);
begin
 Self.CreateButton.Enabled:=Self.check_input();
end;

procedure TMainWindow.OpenSfxButtonClick(Sender: TObject);
begin
 Self.OpenDialog.FileName:='';
 Self.OpenDialog.DefaultExt:='*.sfx';
 Self.OpenDialog.Filter:='A SFX module|*.sfx';
 if Self.OpenDialog.Execute()=True then
 begin
  Self.SfxField.Text:=Self.OpenDialog.FileName;
 end;

end;

procedure TMainWindow.OpenConfigurationButtonClick(Sender: TObject);
begin
 Self.OpenDialog.FileName:='';
 Self.OpenDialog.DefaultExt:='*.txt';
 Self.OpenDialog.Filter:='A configuration file|*.txt';
 if Self.OpenDialog.Execute()=True then
 begin
  Self.ConfigurationField.Text:=Self.OpenDialog.FileName;
 end;

end;

procedure TMainWindow.OpenArchiveButtonClick(Sender: TObject);
begin
 Self.OpenDialog.FileName:='';
 Self.OpenDialog.DefaultExt:='*.7z';
 Self.OpenDialog.Filter:='A 7-ZIP archive|*.7z';
 if Self.OpenDialog.Execute()=True then
 begin
  Self.ArchiveField.Text:=Self.OpenDialog.FileName;
 end;

end;

procedure TMainWindow.CreateButtonClick(Sender: TObject);
begin
 Self.OpenSfxButton.Enabled:=False;
 Self.OpenConfigurationButton.Enabled:=False;
 Self.OpenArchiveButton.Enabled:=False;
 Self.CreateButton.Enabled:=False;
 if create_sfx(Self.SfxField.Text,Self.ConfigurationField.Text,Self.ArchiveField.Text)=True then
 begin
  ShowMessage('A self-extraction archive was successfully created');
 end
 else
 begin
  ShowMessage('A self-extraction archive creation has failed');
 end;
 Self.OpenSfxButton.Enabled:=True;
 Self.OpenConfigurationButton.Enabled:=True;
 Self.OpenArchiveButton.Enabled:=True;
 Self.CreateButton.Enabled:=True;
end;

{$R *.lfm}

end.
