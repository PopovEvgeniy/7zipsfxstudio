unit sevenzipsfxstudiocode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, LazFileUtils, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure LabeledEdit3Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var Form1: TForm1;

implementation

function create_sfx(const module:string;const cfg:string;const source:string):boolean;
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
  ;
 end;
 if sfx<>nil then sfx.Free();
 if configuration<>nil then configuration.Free();
 if archive<>nil then archive.Free();
 if sfx_archive<>nil then sfx_archive.Free();
 create_sfx:=FileExists(target);
end;

procedure window_setup();
begin
 Application.Title:='7-ZIP SFX STUDIO';
 Form1.Caption:='7-ZIP SFX STUDIO 2.3.3';
 Form1.BorderStyle:=bsDialog;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure interface_setup();
begin
 Form1.Button1.ShowHint:=False;
 Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
 Form1.Button3.ShowHint:=Form1.Button1.ShowHint;
 Form1.Button4.ShowHint:=Form1.Button1.ShowHint;
 Form1.Button4.Enabled:=False;
 Form1.StatusBar1.Visible:=False;
 Form1.LabeledEdit1.Text:='';
 Form1.LabeledEdit2.Text:=Form1.LabeledEdit1.Text;
 Form1.LabeledEdit3.Text:=Form1.LabeledEdit1.Text;
 Form1.LabeledEdit1.LabelPosition:=lpLeft;
 Form1.LabeledEdit2.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
 Form1.LabeledEdit3.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
 Form1.LabeledEdit1.Enabled:=False;
 Form1.LabeledEdit2.Enabled:=Form1.LabeledEdit1.Enabled;
 Form1.LabeledEdit3.Enabled:=Form1.LabeledEdit1.Enabled;
end;

procedure language_setup();
begin
 Form1.Button1.Caption:='Open';
 Form1.Button2.Caption:='Open';
 Form1.Button3.Caption:='Open';
 Form1.Button4.Caption:='Create the self-extracting archive';
 Form1.LabeledEdit1.EditLabel.Caption:='Self-extracting module';
 Form1.LabeledEdit2.EditLabel.Caption:='Configuration file';
 Form1.LabeledEdit3.EditLabel.Caption:='Archive';
 Form1.OpenDialog1.Title:='Open the existing file';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
 Form1.Button4.Enabled:=(Form1.LabeledEdit1.Text<>'') and (Form1.LabeledEdit2.Text<>'') and (Form1.LabeledEdit3.Text<>'');
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
 Form1.Button4.Enabled:=(Form1.LabeledEdit1.Text<>'') and (Form1.LabeledEdit2.Text<>'') and (Form1.LabeledEdit3.Text<>'');
end;

procedure TForm1.LabeledEdit3Change(Sender: TObject);
begin
 Form1.Button4.Enabled:=(Form1.LabeledEdit1.Text<>'') and (Form1.LabeledEdit2.Text<>'') and (Form1.LabeledEdit3.Text<>'');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Form1.OpenDialog1.FileName:='*.sfx';
 Form1.OpenDialog1.DefaultExt:='*.sfx';
 Form1.OpenDialog1.Filter:='SFX module|*.sfx';
 if Form1.OpenDialog1.Execute()=True then
 begin
  Form1.LabeledEdit1.Text:=Form1.OpenDialog1.FileName;
 end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Form1.OpenDialog1.FileName:='*.txt';
 Form1.OpenDialog1.DefaultExt:='*.txt';
 Form1.OpenDialog1.Filter:='Configuration file|*.txt';
 if Form1.OpenDialog1.Execute()=True then
 begin
  Form1.LabeledEdit2.Text:=Form1.OpenDialog1.FileName;
 end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 Form1.OpenDialog1.FileName:='*.7z';
 Form1.OpenDialog1.DefaultExt:='*.7z';
 Form1.OpenDialog1.Filter:='7-ZIP archive|*.7z';
 if Form1.OpenDialog1.Execute()=True then
 begin
  Form1.LabeledEdit3.Text:=Form1.OpenDialog1.FileName;
 end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 Form1.Button1.Enabled:=False;
 Form1.Button2.Enabled:=False;
 Form1.Button3.Enabled:=False;
 Form1.Button4.Enabled:=False;
 Form1.StatusBar1.Visible:=True;
 Form1.StatusBar1.SimpleText:='Working... Please wait';
 if create_sfx(Form1.LabeledEdit1.Text,Form1.LabeledEdit2.Text,Form1.LabeledEdit3.Text)=True then
 begin
  Form1.StatusBar1.SimpleText:='A self-extraction archive was successfully created';
 end
 else
 begin
  Form1.StatusBar1.SimpleText:='A self-extraction archive creation was failed';
 end;
 Form1.Button1.Enabled:=True;
 Form1.Button2.Enabled:=True;
 Form1.Button3.Enabled:=True;
 Form1.Button4.Enabled:=True;
end;

{$R *.lfm}

{ TForm1 }

{ TForm1 }

end.
