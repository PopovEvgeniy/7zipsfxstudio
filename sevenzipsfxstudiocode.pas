unit sevenzipsfxstudiocode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, LazFileUtils, ComCtrls;

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
    { private declarations }
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure create_sfx(const module:string;const cfg:string;const source:string);
var target:string;
var sfx,configuration,archive,sfx_archive:TFileStream;
begin
 target:=ExtractFileNameWithoutExt(source)+'.exe';
 sfx:=nil;
 configuration:=nil;
 archive:=nil;
 sfx_archive:=nil;
 try
  sfx:=TFileStream.Create(module,fmOpenRead);
  configuration:=TFileStream.Create(cfg,fmOpenRead);
  archive:=TFileStream.Create(source,fmOpenRead);
  sfx_archive:=TFileStream.Create(target,fmCreate);
  sfx_archive.CopyFrom(sfx,0);
  sfx_archive.CopyFrom(configuration,0);
  sfx_archive.CopyFrom(archive,0);
 except
  ShowMessage('A self-extraction archive creation failed');
 end;
 if sfx<>nil then sfx.Free();
 if configuration<>nil then configuration.Free();
 if archive<>nil then archive.Free();
 if sfx_archive<>nil then sfx_archive.Free();
end;

procedure window_setup();
begin
 Application.Title:='7-ZIP SFX STUDIO';
 MainWindow.Caption:='7-ZIP SFX STUDIO 2.3.6';
 MainWindow.BorderStyle:=bsDialog;
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure interface_setup();
begin
 MainWindow.OpenSfxButton.ShowHint:=False;
 MainWindow.OpenConfigurationButton.ShowHint:=MainWindow.OpenSfxButton.ShowHint;
 MainWindow.OpenArchiveButton.ShowHint:=MainWindow.OpenSfxButton.ShowHint;
 MainWindow.CreateButton.ShowHint:=MainWindow.OpenSfxButton.ShowHint;
 MainWindow.CreateButton.Enabled:=False;
 MainWindow.SfxField.Text:='';
 MainWindow.ConfigurationField.Text:=MainWindow.SfxField.Text;
 MainWindow.ArchiveField.Text:=MainWindow.SfxField.Text;
 MainWindow.SfxField.LabelPosition:=lpLeft;
 MainWindow.ConfigurationField.LabelPosition:=MainWindow.SfxField.LabelPosition;
 MainWindow.ArchiveField.LabelPosition:=MainWindow.SfxField.LabelPosition;
 MainWindow.SfxField.Enabled:=False;
 MainWindow.ConfigurationField.Enabled:=MainWindow.SfxField.Enabled;
 MainWindow.ArchiveField.Enabled:=MainWindow.SfxField.Enabled;
end;

procedure language_setup();
begin
 MainWindow.OpenSfxButton.Caption:='Open';
 MainWindow.OpenConfigurationButton.Caption:='Open';
 MainWindow.OpenArchiveButton.Caption:='Open';
 MainWindow.CreateButton.Caption:='Create the self-extracting archive';
 MainWindow.SfxField.EditLabel.Caption:='A self-extracting module';
 MainWindow.ConfigurationField.EditLabel.Caption:='A configuration file';
 MainWindow.ArchiveField.EditLabel.Caption:='An archive';
 MainWindow.OpenDialog.Title:='Open the existing file';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TMainWindow.SfxFieldChange(Sender: TObject);
begin
 MainWindow.CreateButton.Enabled:=(MainWindow.SfxField.Text<>'') and (MainWindow.ConfigurationField.Text<>'') and (MainWindow.ArchiveField.Text<>'');
end;

procedure TMainWindow.ConfigurationFieldChange(Sender: TObject);
begin
 MainWindow.CreateButton.Enabled:=(MainWindow.SfxField.Text<>'') and (MainWindow.ConfigurationField.Text<>'') and (MainWindow.ArchiveField.Text<>'');
end;

procedure TMainWindow.ArchiveFieldChange(Sender: TObject);
begin
 MainWindow.CreateButton.Enabled:=(MainWindow.SfxField.Text<>'') and (MainWindow.ConfigurationField.Text<>'') and (MainWindow.ArchiveField.Text<>'');
end;

procedure TMainWindow.OpenSfxButtonClick(Sender: TObject);
begin
 MainWindow.OpenDialog.FileName:='*.sfx';
 MainWindow.OpenDialog.DefaultExt:='*.sfx';
 MainWindow.OpenDialog.Filter:='A SFX module|*.sfx';
 if MainWindow.OpenDialog.Execute()=True then
 begin
  MainWindow.SfxField.Text:=MainWindow.OpenDialog.FileName;
 end;

end;

procedure TMainWindow.OpenConfigurationButtonClick(Sender: TObject);
begin
 MainWindow.OpenDialog.FileName:='*.txt';
 MainWindow.OpenDialog.DefaultExt:='*.txt';
 MainWindow.OpenDialog.Filter:='A configuration file|*.txt';
 if MainWindow.OpenDialog.Execute()=True then
 begin
  MainWindow.ConfigurationField.Text:=MainWindow.OpenDialog.FileName;
 end;

end;

procedure TMainWindow.OpenArchiveButtonClick(Sender: TObject);
begin
 MainWindow.OpenDialog.FileName:='*.7z';
 MainWindow.OpenDialog.DefaultExt:='*.7z';
 MainWindow.OpenDialog.Filter:='A 7-ZIP archive|*.7z';
 if MainWindow.OpenDialog.Execute()=True then
 begin
  MainWindow.ArchiveField.Text:=MainWindow.OpenDialog.FileName;
 end;

end;

procedure TMainWindow.CreateButtonClick(Sender: TObject);
begin
 MainWindow.OpenSfxButton.Enabled:=False;
 MainWindow.OpenConfigurationButton.Enabled:=False;
 MainWindow.OpenArchiveButton.Enabled:=False;
 MainWindow.CreateButton.Enabled:=False;
 create_sfx(MainWindow.SfxField.Text,MainWindow.ConfigurationField.Text,MainWindow.ArchiveField.Text);
 MainWindow.OpenSfxButton.Enabled:=True;
 MainWindow.OpenConfigurationButton.Enabled:=True;
 MainWindow.OpenArchiveButton.Enabled:=True;
 MainWindow.CreateButton.Enabled:=True;
end;

{$R *.lfm}

end.
